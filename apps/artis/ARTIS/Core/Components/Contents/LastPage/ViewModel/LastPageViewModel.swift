//
//  LastPageViewModel.swift
//  ARTIS
//
//  Created by 정소윤 on 2021/12/06.
//

import Foundation
import Combine

class LastPageViewModel: ObservableObject {
    
    @Published var ex_info: ExhibitionInfo? = nil
    @Published var launch_info: LaunchInfo? = nil // need to be handeled.
    @Published var brand_info: BrandInfo? = nil // need to be handeled.
    
    private let news: News
    private let DataService = NewsDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init (news: News) {
        
        self.news = news
        
        addSubscribers()
    }
    
    private func addSubscribers() {
        
        DataService.$exhibionInfo
            .receive(on: DispatchQueue.main)
            .sink { [weak self] info in
                        
                self?.ex_info = info
            }
            .store(in: &cancellables)
        
        DataService.$launchInfo
            .receive(on: DispatchQueue.main)
            .sink { [weak self] info in
                        
                self?.launch_info = info
            }
            .store(in: &cancellables)
        
        DataService.$brandInfo
            .receive(on: DispatchQueue.main)
            .sink { [weak self] info in
                        
                self?.brand_info = info
            }
            .store(in: &cancellables)
    }
    
    func getInfo(_ db_collection: String) {
        
        DataService.getInfo(db_collection, news)
    }
}
