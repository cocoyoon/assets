//
//  NewsImageDataService.swift
//  ARTIS
//
//  Created by 정소윤 on 2021/12/01.
//

import Foundation
import Firebase
import UIKit

class NewsImageDataService {
    
    @Published var coverImage: UIImage? = nil
    @Published var contentsImage: UIImage? = nil
    
    private let cache = LocalFileManager.instance
    private let news: News
    private let category: String
    private let id: String

    init(news: News) {
        
        self.news = news
        self.category = news.map()
        self.id = news.id
        
        downloadCoverImage()
    }
    
   func downloadCoverImage() {
       
       if let savedImage = cache.getCoverImage(cache_dir: "cover", id: id) {
            
            self.coverImage = savedImage
        } else {
            
            getCoverImageFromStorage()
        }
    }
    
    func downloadContentsImage(_ num: Int) {
        
        if let savedImage = cache.getContentsImage(cache_dir: "contents", num: num) {
            
            self.contentsImage = savedImage
        } else {
            
            getContentsImageFromStorage(num)
        }
    }
    
    func saveContentsAtCacheWhenLoaded(_ num: Int) {
        
        saveContentsAtCache(num)
    }
    
    private func getCoverImageFromStorage() {
        
        let ref = imageRef(of: "cover").child("cover.png")
        
        NetworkManager.downloadCoverImage(ref: ref) { data in
            
            guard let image = UIImage(data:data) else {return}
            
            self.coverImage = image
            self.cache.saveCoverImage(image: image, cache_dir: "cover", id: self.id)
        }
    }
    
    private func getContentsImageFromStorage(_ num: Int) {
        
        let ref = imageRef(of: "contents")
        
        NetworkManager.downloadContentsImage(ref: ref, num: num) { (data) in
            
            guard let image = UIImage(data: data) else {return}
            self.contentsImage = image
            self.cache.saveContentsImage(image: image, cache_dir: "contents", num: num)
        }
    }
    
    private func saveContentsAtCache(_ num: Int) {
        
        let ref = imageRef(of: "contents")
        
        NetworkManager.downloadContentsImage(ref: ref, num: num) { (data) in
            
            guard let image = UIImage(data: data) else {return}
            self.cache.saveContentsImage(image: image, cache_dir: "contents", num: num)
        }
    }
    
    private func imageRef(of: String) -> StorageReference {
        
        let storageRef = Storage.storage().reference()
        let imageRef = storageRef.child("\(category)/\(id)/\(of)")
        
        return imageRef
    }
}
