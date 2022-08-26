//
//  UIApplication.swift
//  ARTIS
//
//  Created by 정소윤 on 2021/12/07.
//

import Foundation
import SwiftUI

extension UIApplication {
    
    func endEditing() {
        
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
