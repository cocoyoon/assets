//
//  DateFormat.swift
//  ARTIS
//
//  Created by 정소윤 on 2021/12/04.
//

import Foundation

extension Date {
    
    var format: String {
        
        let time = Calendar.current
        let year = time.component(.year, from: self)
        let month = time.component(.month, from: self)
        let day = time.component(.day, from: self)
        
        let timeFormat: String = "\(year)년 \(month)월 \(day)일"
        
        return timeFormat
    }
}
