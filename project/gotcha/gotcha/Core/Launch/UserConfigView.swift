//
//  UserConfigView.swift
//  gotcha
//
//  Created by SoYounJeong on 2022/10/21.
//

import SwiftUI

struct UserConfigView: View {
    
    var body: some View {
        ZStack {
            Color
                .theme.SheetBackground
                .ignoresSafeArea()
            
            Image("LaunchImage")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
    
            VStack {
                
                UserConfigTextField()
            }
        }
    }
}

struct UserConfigView_Previews: PreviewProvider {
    static var previews: some View {
        UserConfigView()
    }
}
