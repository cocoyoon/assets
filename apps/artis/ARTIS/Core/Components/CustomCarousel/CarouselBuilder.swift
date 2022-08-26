//
//  CarouselBuilder.swift
//  ARTIS
//
//  Created by 정소윤 on 2021/12/04.
//

import SwiftUI

struct CarouselBuilder<Content:View>: View {
    
    var carousel: Content
    
    init(anyViewArr: [AnyView], titleArr: [String], @ViewBuilder CustomCarousel: @escaping ([AnyView],[String]) -> Content) {
        
        self.carousel = CustomCarousel(anyViewArr,titleArr)
    }
    
    var body: some View {
        
        carousel
    }
}

//
//struct CarouselBuilder_Previews: PreviewProvider {
//    static var previews: some View {
//
//
//        CarouselBuilder()
//    }
//}
