//
//  LatestNewsView.swift
//  LatestNewsView
//
//  Created by 정소윤 on 2021/09/29.
//

import SwiftUI

struct NewsRowView: View {
    
    let news: News
    @State private var isContentsShow = false
    
    var body: some View {
        
        newsView
            .background(
                
                NavigationLink (isActive: $isContentsShow, destination: {
                    ContentsView(news: news, of: news.category)
                }, label: {
                    EmptyView()
                })
            )
    }
}

struct LatestNewsView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        NewsRowView(news: dev.news)
    }
}

extension NewsRowView {
    
    private var newsView: some View {
        
        ZStack {
            
            RoundedRectangle(cornerRadius: 20)
                .frame(width: UIScreen.main.bounds.width-30, height: UIScreen.main.bounds.width/3)
                .foregroundColor(Color.theme.newsColor)
            
            VStack {
                
                HStack(alignment: .top) {
                    
                    VStack(alignment: .leading) {
                        
                        VStack(alignment: .leading, spacing: 5) {
                            
                            Text(news.category)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundColor(Color.theme.TextColor)
                            
                            HStack {
                                
                                Text(Date(timeIntervalSince1970: news.createdAt).format)
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color.theme.TextColor)
                                
                                HStack {
                                    Image(systemName: "eye")
                                        .font(.caption)
                                        .foregroundColor(Color.theme.TextColor)
                                    
                                    Text(String(news.read))
                                        .font(.caption)
                                        .foregroundColor(Color.theme.TextColor)
                                    
                                }.padding(.horizontal,5)
                                
                                Spacer()
                            }
                        }
                        
                        Spacer()
                        Text(news.title)
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(Color.theme.TextColor)
                            .padding(.bottom)
                    }
                    .padding(.top,10)
                    
                    VStack {
                        
                        Spacer()
                        
                        NewsImageView(news: news)
                        
                        Spacer()
                    }
                }
                .padding(.horizontal,20)
                .frame(maxWidth: UIScreen.main.bounds.width - 30,maxHeight: UIScreen.main.bounds.width/3.5)
            }
        }
    }
}
