//
//  ContentView.swift
//  gotcha
//
//  Created by SoYoun Jeong on 2022/10/18.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack(alignment: .topLeading) {
            ScrollView([.horizontal, .vertical], showsIndicators: false)
            {
                VStack(spacing: 30) {
                    ForEach(0..<20) { row in
                        HStack(spacing: 20) {
                            ForEach(0..<20) { column in
                                RoundedRectangle(cornerRadius: 20)
                                    .frame(width: 200, height: 300)
                                    .foregroundColor(Color.gray)
                            }
                        }
                    }
                }.frame(maxWidth: .infinity)
            }.font(.largeTitle)
            Text("GOTCHA")
                .padding(20)
                .fontWeight(.bold)
                .font(.title)
                .foregroundColor(Color.red)
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
