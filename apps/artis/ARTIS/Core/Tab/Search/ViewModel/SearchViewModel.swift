//
//  SearchViewModel.swift
//  ARTIS
//
//  Created by 정소윤 on 2021/12/08.
//

import Foundation
import Combine

class SearchViewModel: ObservableObject {
    
    @Published var filteredNews: [News] = []
    @Published var trendNews: [News] = []
    @Published var textSearch: String = ""
    
    private let DataService: NewsDataService = NewsDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        
        addSubscriber()
    }
    
    private func addSubscriber() {
        
        $textSearch
            .combineLatest(DataService.$all_news)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filter)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] returnedFilteredNews in
                
                self?.filteredNews = returnedFilteredNews
            }
            .store(in: &cancellables)
        
        DataService.$main_news
            .receive(on: DispatchQueue.main)
            .sink { [weak self] returnedTrendNews in
                
                self?.trendNews = returnedTrendNews
            }
            .store(in: &cancellables)
    }

    private func filter(text: String, all_news: [News]) -> [News] {
        
        guard !text.isEmpty else {
            
            return []
        }
        
        return all_news.filter { (news) -> Bool in
            
            return news.title.contains(text) ||
                   news.category.contains(text) ||
                   news.tag.contains { tag in
                        
                       tag.contains(text)
                   }
        }
    }
}
