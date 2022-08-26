//
//  PreviewProvider.swift
//  ARTIS
//
//  Created by 정소윤 on 2021/11/30.
//

import Foundation
import SwiftUI

extension PreviewProvider {
    
    static var dev: DeveloperPreview {
        
        return DeveloperPreview.instance
    }
}

class DeveloperPreview {
    
    static var instance: DeveloperPreview = DeveloperPreview()
    private init() {}
    
    let homeVM: HomeViewModel = HomeViewModel()
    
    let news: News = News(id: "TryWcXnqhQG4IgNjl8pL", category: "전시회", contents: 3, createdAt: 1638258792, read: 10, tag: ["식물관 PH"], title: "Artificial Plants")
}
