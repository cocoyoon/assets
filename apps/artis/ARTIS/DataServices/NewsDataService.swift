//
//  NewsDataService.swift
//  ARTIS
//
//  Created by 정소윤 on 2021/11/30.
//

import Foundation
import Firebase

class NewsDataService {
    
    @Published var all_news: [News] = []
    @Published var main_news: [News] = []
    @Published var exhibionInfo: ExhibitionInfo? = nil
    @Published var launchInfo: LaunchInfo? = nil
    @Published var brandInfo: BrandInfo? = nil
    
    private let collections: [String] = ["launch","brand","exhibition"]
    
    init() {
        
        downloadNews()
    }
    
    private func downloadNews() {
        
        getMainNews()
        getAllNews()
    }
    
    private func getAllNews() {
        
        for collection in collections {
            
            NetworkManager.downloadNewsData(collection: collection) { news in
                
                self.all_news.append(contentsOf: news)
            }
        }
    }
    
    private func getMainNews() {
        
        NetworkManager.downloadNewsData(collection: "main") { news in
            
            self.main_news = news
        }
    }
    
    func getInfo(_ db_collection: String, _ news: News) {
        
        let docRef = infoRef(collection: db_collection, id: news.id)
        
        switch db_collection {
            
        case "ex_info":
            NetworkManager.downloadExhibitionInfo(ref: docRef) { info in
                self.exhibionInfo = info
            }
        case "launch_info":
            NetworkManager.downloadLaunchInfo(ref: docRef) { info in
                self.launchInfo = info
            }
        default:
            NetworkManager.downloadBrandInfo(ref: docRef) { info in
                self.brandInfo = info
            }
        }
    }
    
    private func infoRef(collection: String, id: String) -> DocumentReference {
        
        let db = Firestore.firestore().collection(collection).document(id)
        
        return db
    }
}
