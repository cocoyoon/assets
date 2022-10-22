//
//  ContentView.swift
//  gotcha
//
//  Created by SoYoun Jeong on 2022/10/18.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var AuthVM: GoogleAuth
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            ScrollView([.horizontal, .vertical], showsIndicators: false)
            {
                VStack(spacing: 20) {
                    ForEach(0..<40) { _ in
                        HStack(spacing: 20) {
                            ForEach(0..<10) { _ in
                                RoundedRectangle(cornerRadius: 20)
                                    .frame(width: 250, height: 400)
                                    .foregroundColor(Color.theme.SheetBackground)
                            }
                        }
                    }
                }.frame(maxWidth: .infinity)
            }.font(.largeTitle)
            Text("GOTCHA")
                .padding(20)
                .fontWeight(.bold)
                .font(.custom("Bangers", fixedSize: 50))
                .foregroundColor(Color.theme.Signature)
                .onTapGesture {
                    AuthVM.signOut()
                }
        }
        .background(Color.theme.MainBackground)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
