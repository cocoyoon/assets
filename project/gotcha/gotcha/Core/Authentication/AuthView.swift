//
//  AuthView.swift
//  gotcha
//
//  Created by SoYoun Jeong on 2022/10/20.
//

import SwiftUI

struct AuthView: View {
    
    @EnvironmentObject var AuthVM: AuthViewModel
    
    var body: some View {
        VStack {
            
          Spacer()

          Image("header_image")
            .resizable()
            .aspectRatio(contentMode: .fit)

          Text("Welcome to Ellifit!")
            .fontWeight(.black)
            .foregroundColor(Color(.systemIndigo))
            .font(.largeTitle)
            .multilineTextAlignment(.center)

          Text("Empower your elliptical workouts by tracking every move.")
            .fontWeight(.light)
            .multilineTextAlignment(.center)
            .padding()

          Spacer()

          GoogleSignInButton()
            .padding()
            .onTapGesture {
              AuthVM.signIn()
            }
        }
      }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
