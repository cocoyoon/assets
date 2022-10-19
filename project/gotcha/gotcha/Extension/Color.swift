//
//  Colors.swift
//  GOTCHA
//
//  Created by yoon on 2022/06/25.
//

import Foundation
import SwiftUI

extension Color {
    
    static let theme = ColorTheme()
}

/// Color theme for GOTCHA
struct ColorTheme {
    
    let MainBackground = Color("MainBackground")
    let SheetBackground = Color("SheetBackground")
    let Signature = Color("Signature")
    let MainText = Color("MainText")
    let SubText = Color("SubText")
}
