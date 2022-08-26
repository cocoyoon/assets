
import Foundation
import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var all_news: [News] = []
    @Published var main_news: [News] = []
    
    private let newsDataService = NewsDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        
        fetchData()
    }
    
    func fetchData() {
        
        newsDataService.$all_news
            .receive(on: DispatchQueue.main)
            .sink { [weak self] returnedNews in
                
                self?.all_news = returnedNews
            }
            .store(in: &cancellables)
        
        newsDataService.$main_news
            .receive(on: DispatchQueue.main)
            .sink { [weak self] returnedNews in
                
                self?.main_news = returnedNews
            }
            .store(in: &cancellables)
    }
}

//    func carousel() {
//
//        print(main_news)
//
//        self.AnyViewList = []
//        self.titleList = []
//
//        for index in 0 ..< main_news.count {
//
//            let ImgaeVM = NewsImageViewModel(news: main_news[index])
//            if let image = ImgaeVM.coverImage {
//
//                AnyViewList.append(AnyView(Image(uiImage: image).resizable()))
//                titleList.append(main_news[index].title)
//            }
//        }
//    }
