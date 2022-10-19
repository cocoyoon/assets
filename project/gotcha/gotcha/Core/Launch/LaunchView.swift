//
//  LaunchView.swift
//  gotcha
//
//  Created by SoYoun Jeong on 2022/10/19.
//

import SwiftUI

struct LaunchView: View {
    
    @EnvironmentObject var AuthVM: AuthViewModel
    
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
                
                Text("GOTCHA")
                    .foregroundColor(Color.theme.Signature)
                    .font(.custom("Bangers", fixedSize: 100))
                    .padding(.bottom, 200)
                
                GoogleSignInButton()
            }
        }
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}
