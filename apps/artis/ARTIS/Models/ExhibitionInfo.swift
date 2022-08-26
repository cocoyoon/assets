//
//  ExhibtionInfo.swift
//  ARTIS
//
//  Created by 정소윤 on 2021/12/06.
//

import Foundation

struct ExhibitionInfo: Identifiable {
    
    let id: String
    let artist: String
    let isProgress: Bool
    let location: String
    let period: [String:Double]
    let score: Double
    let sns: String
    let title: String
    
    func score_comment() -> String {
        
        switch self.score {
            
        case 4.0 ... 5.0:
            return "꼭 한번 가보세요! 😝"
            
        case 3.0 ..< 4.0:
            return "가볼만 해요 😐"
        
        case 2.0 ..< 3.0:
             return "흠...🥲"
            
        default:
            return "돈 아까워요 ⚠️"
        }
    }
}
