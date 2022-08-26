//
//  NewsView.swift
//  ARTIS
//
//  Created by 정소윤 on 2021/12/12.
//

import SwiftUI

struct NewsView: View {
    
    private let news: [News]
    @State private var selection: String? = nil
    
    init(news: [News]) {
        
        self.news = news
    }
    
    var body: some View {
        
        VStack {
            
            ForEach(0 ..< news.count, id: \.self) { (index) in
                
                NewsRowView(news: news[index])
                    .onTapGesture {
                        self.selection = news[index].id
                    }
                    .background(
                        
                        NavigationLink(tag: news[index].id, selection: $selection, destination: {
                            ContentsView(news: news[index], of: news[index].category)
                        }, label: {
                            EmptyView()
                        })
                        
                    )
            }
        }
    }
}
//
//struct NewsView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewsView(news: [dev.news])
//    }
//}
