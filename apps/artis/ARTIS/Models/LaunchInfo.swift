//
//  BrandInfo.swift
//  ARTIS
//
//  Created by 정소윤 on 2021/12/06.
//

import Foundation

struct LaunchInfo: Identifiable {
    
    let id: String
    let period: [String:Double]
    let price: Int
    let title: String
    let web: [String:(period: Double, address: String)]
}
