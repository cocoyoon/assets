//
//  SheetView.swift
//  GOTCHA
//
//  Created by yoon on 2022/07/03.
//

import SwiftUI

struct SheetView: View {
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Text("사진을 요청해 주세요!")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(Color.theme.MainText)
                    .padding()
                
                Spacer()
            }
            
            RoundedRectangle(cornerRadius: 20)
                .frame(width: UIScreen.main.bounds.width - 200, height: UIScreen.main.bounds.height / 4)
                .overlay(
                    Image(systemName: "photo.circle")
                        .foregroundColor(Color.theme.MainText)
                        .font(.title)
                )
                .padding()
            Spacer()
        }
        .background(Color.theme.SheetBackground)
        .ignoresSafeArea()
    }
}

struct SheetView_Previews: PreviewProvider {
    static var previews: some View {
        SheetView()
    }
}
