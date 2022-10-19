//
//  TabView.swift
//  GOTCHA
//
//  Created by yoon on 2022/06/25.
//

import SwiftUI

struct TabView: View {
    
    @State private var tabIndex: Int = 0
    @State private var isPlusBtnTouch = false
    
    var body: some View {
        ZStack {
            Color
                .theme.MainBackground
                .ignoresSafeArea()
            
            ZStack {
                switch tabIndex {
                case 0:
                    HomeView()
                case 1:
                    HomeView()
                default:
                    ProfileView()
                }
            }
            .overlay(
                Tabs
                ,alignment: .bottom
            )
        }
        .overlay {
            if isPlusBtnTouch {
                Color.black.opacity(0.5).ignoresSafeArea()
            }
        }
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        TabView()
    }
}

extension TabView {
    
    private var Tabs: some View {
        HStack {
            ForEach(0 ..< 3, id: \.self) { (currentIndex) in
                
                let tabName = TabItem[currentIndex].name
                Image(systemName: tabName)
                    .padding(.leading, tabName == "plus" ? 60 : 0)
                    .padding(.trailing, tabName == "plus" ? 60 : 0)
                    .font(tabName == "plus" ? Font.system(size: 30, weight: .bold) : .title3)
                    .foregroundColor(
                        tabIndex == currentIndex && tabIndex != 1
                        ? Color.theme.Signature
                        : Color.theme.MainText
                    )
                    .onTapGesture {
                        tabIndex = currentIndex
                        if tabName == "plus" {
                            isPlusBtnTouch.toggle()
                        }
                    }
            }
        }
        .frame(width: UIScreen.main.bounds.width - 50, height: 80)
        .background(Color.theme.SheetBackground)
        .cornerRadius(20)
    }
}

struct Tab {
    
    let name: String
}

var TabItem: [Tab] = [
    Tab(name: "house.fill"),
    Tab(name: "plus"),
    Tab(name: "person.fill")
]
