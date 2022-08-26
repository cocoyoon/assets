//
//  mainNewsView.swift
//  ARTIS
//
//  Created by 정소윤 on 2021/12/05.
//

import SwiftUI

struct mainNewsView: View {
    
    @State private var isContentShow: Bool = false
    @State private var isNewsShow: Bool = false
    @Namespace private var namespace
    
    private let news: [News]
    
    init(all_news: [News]) {
    
        self.news = all_news
    }
    
    var body: some View {
        
        TabView {
            
            ForEach(0 ..< news.count, id: \.self) { index in
                
                MainNewsImageView(news: news[index])
                    .onTapGesture {
                        
                        self.isContentShow = true
                    }
                    .background(
                        NavigationLink(isActive: $isContentShow, destination: {
                            
                            ContentsView(news: news[index], of: news[index].category)
                        }, label: {
                            EmptyView()
                        })
                    )
                    .padding(.horizontal)
            }
        }
        .tabViewStyle(.page)
        .aspectRatio(CGSize(width: 1.6, height: 1.2), contentMode: .fit)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding()
    }
}

//
//struct mainNewsView_Previews: PreviewProvider {
//    static var previews: some View {
//        mainNewsView(mainNews: <#T##[News]#>)
//    }
//}
