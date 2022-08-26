//
//  testView.swift
//  ARTIS
//
//  Created by 정소윤 on 2021/11/30.
//

import SwiftUI

struct testView: View {
    
    @State private var offset: CGFloat = .zero
    
    var body: some View {
        
        ScrollView(.horizontal, showsIndicators: false) {
            
            HStack {
                
                ForEach(1...10, id: \.self) { _ in
                    
                    GeometryReader { proxy in
                        
                        ZStack {
                        
                            Rectangle()
                                .cornerRadius(20)
                            
                            Text("\(getScale(proxy:proxy))")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(Color.white)
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width - 60, height: UIScreen.main.bounds.height/2)
                }
            }
            .padding()
        }
    }
    
    private func getScale(proxy: GeometryProxy) -> CGFloat {
        
        let frame = proxy.frame(in: .global)
        
        return frame.origin.x
    }
}

struct testView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        testView()
    }
}
