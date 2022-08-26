//
//  NewsImageViewModel.swift
//  ARTIS
//
//  Created by 정소윤 on 2021/12/01.
//

import Foundation
import Firebase
import UIKit
import Combine

class NewsImageViewModel: ObservableObject {

    @Published var coverImage: UIImage? = nil
    @Published var contentsImages: UIImage? = nil
    @Published var isLoading: Bool = false
    @Published var isContentsLoading: Bool = false
    @Published var contentsBuffer: [UIImage] = []
    
    private let news: News
    private let cache = LocalFileManager.instance
    private let DataService: NewsImageDataService // communication part
    private var cancellable = Set<AnyCancellable>()
    
    init(news: News) {
        
        self.news = news
        self.DataService = NewsImageDataService(news: news)
        self.isLoading = true
        self.isContentsLoading = true
        
        addSubscribers()
    }
    
    private func addSubscribers() {
        
        DataService.$coverImage
            .sink { [weak self] _ in
                self?.isLoading = false
            } receiveValue: { [weak self] returnedCoverImage in
                self?.coverImage = returnedCoverImage
            }
            .store(in: &cancellable)
        
        DataService.$contentsImage
            .sink { [weak self] _ in
                self?.isContentsLoading = false
            } receiveValue: { returnedContentsImages in
                self.contentsImages = returnedContentsImages
            }
            .store(in: &cancellable)
    }
    
    func downloadCoverImage() {
        
        DataService.downloadCoverImage()
    }
    
    func downloadContentsImage(_ of: Int) {
        
        DataService.downloadContentsImage(of)
    }
    
    func removeContentsImageFromCache() {
        
        cache.removeContentsImage(cache_dir: "contents")
    }
    
    func downloadContentBackground(contentNum: Int) {
        
        for i in 2...contentNum {
            
            DataService.saveContentsAtCacheWhenLoaded(i)
        }
    }
}
