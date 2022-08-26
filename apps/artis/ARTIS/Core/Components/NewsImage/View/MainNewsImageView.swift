//
//  MainNewsView.swift
//  ARTIS
//
//  Created by 정소윤 on 2021/12/03.
//

import SwiftUI

struct MainNewsImageView: View {
    
    @StateObject var vm: NewsImageViewModel
    private var newsTitle: String
    
    init(news: News) {
        
        _vm = StateObject(wrappedValue: NewsImageViewModel(news: news))
        self.newsTitle = news.title
    }
    
    var body: some View {
        
        if let image = vm.coverImage {
            
            ZStack(alignment: .center) {
                
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(CGSize(width: 1.6, height: 1.2 ), contentMode: .fit)
                    .overlay(
                        
                        Color.black.opacity(0.4)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Text(newsTitle)
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
            }
            
        } else if vm.isLoading {
            
            ProgressView()
        } else {
            
            Image(systemName: "questionMark")
                .foregroundColor(Color.theme.TextColor)
        }
    }
}

struct MainNewsView_Previews: PreviewProvider {
    static var previews: some View {
        
        MainNewsImageView(news: dev.news)
    }
}
