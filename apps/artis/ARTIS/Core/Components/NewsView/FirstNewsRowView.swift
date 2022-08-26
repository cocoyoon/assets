//
//  FirstNewsRowView.swift
//  ARTIS
//
//  Created by 정소윤 on 2021/12/12.
//

import SwiftUI

struct FirstNewsRowView: View {
    
    private let news: News
    @StateObject var vm: NewsImageViewModel
    
    init(news: News) {
        
        self.news = news
        _vm = StateObject(wrappedValue: NewsImageViewModel(news: news))
    }
    
    var body: some View {
        
        if let image = vm.coverImage {
            
            VStack(spacing: 0) {
                
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(CGSize(width: 1.6, height: 1.4),contentMode: .fit)
                    .CustomCornerRadius(20, corners: [.topLeft,.topRight])
                
                Rectangle()
                    .aspectRatio(CGSize(width: 1.6, height: 0.8),contentMode: .fit)
                    .foregroundColor(Color.theme.newsColor)
                    .CustomCornerRadius(20, corners: [.bottomLeft,.bottomRight])
                    .overlay(
                    
                        VStack(alignment: .leading) {
                            
                            HStack(spacing: 30) {
                                
                                Text(news.category)
                                    .font(.title2)
                                    .fontWeight(.bold)
                            }
                            
                            Text(news.title)
                                .font(.largeTitle)
                                .fontWeight(.bold)
                            
                            Text(Date(timeIntervalSince1970: news.createdAt).format)
                                .fontWeight(.bold)
                                .padding(.top)
                        }
                            .padding()
                        
                        ,alignment: .topLeading
                    )
            }
            .padding()
        }
    }
}

struct FirstNewsRowView_Previews: PreviewProvider {
    static var previews: some View {
        
        FirstNewsRowView(news: dev.news)
    }
}
