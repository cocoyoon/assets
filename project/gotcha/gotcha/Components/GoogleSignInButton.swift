//
//  GoogleSignInButton.swift
//  gotcha
//
//  Created by SoYoun Jeong on 2022/10/20.
//

import SwiftUI

struct GoogleSignInButton: View {
    
    @EnvironmentObject var GoogleAuthManager: GoogleAuth
    
    var body: some View {
        
        VStack {
            HStack {
               Image("GoogleLogo")
                    .resizable()
                    .aspectRatio(CGSize(width: 1, height: 1), contentMode: .fit)
                    .frame(width: 20, height: 20)
                    .padding()
                    .padding(.leading, 20)
                
                Text("Sign In With Google ")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(Color.theme.MainText)
                    .padding(.trailing, 30)
            }
            .background(Color.theme.MainBackground)
            .cornerRadius(15)
            .onTapGesture {
                GoogleAuthManager.signIn()
            }
        }
    }
}

struct GoogleSignInButton_Previews: PreviewProvider {
    static var previews: some View {
        GoogleSignInButton()
//            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}

