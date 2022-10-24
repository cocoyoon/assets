//
//  LaunchView.swift
//  gotcha
//
//  Created by SoYoun Jeong on 2022/10/19.
//

import SwiftUI

struct LogInView: View {
    
    @EnvironmentObject var GoogleAuthManager: GoogleAuth
    
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
                    .shadow(color: Color.black, radius: 0, x: 5, y: 10)
                
                GoogleSignInButton()
            }
        }
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
