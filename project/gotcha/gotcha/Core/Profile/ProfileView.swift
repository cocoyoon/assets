//
//  ProfileView.swift
//  GOTCHA
//
//  Created by yoon on 2022/06/26.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        ZStack {
            Color
                .theme.MainBackground
                .ignoresSafeArea()
            
            ScrollView {
                VStack {
                    VStack {
                        ZStack {
                            Circle()
                                .fill(Color.theme.SheetBackground)
                                .frame(width: 200, height: 200)
                            Text("Profile")
                                .foregroundColor(Color.theme.MainText)
                                .font(.largeTitle)
                                .fontWeight(.bold)
                        }
                        
                        VStack {
                            
                            Text("ID")
                                .foregroundColor(Color.theme.MainText)
                                .font(.title2)
                                .fontWeight(.bold)
                        }
                        .padding(.top, 30)
                    }
                    
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: .infinity, height: 300)
                        .foregroundColor(Color.theme.SheetBackground)
                        .padding()
                        .padding(.top, 50)
                        .overlay {
                            Text("Saved Items")
                                .foregroundColor(Color.theme.MainText)
                                .fontWeight(.bold)
                        }
                }
                .padding(.top, 30)
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
