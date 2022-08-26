//
//  ARTISApp.swift
//  ARTIS
//
//  Created by 정소윤 on 2021/09/22.
//

import SwiftUI
import Firebase

@main
struct ARTISApp: App {
    
    init() {
        
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        
        WindowGroup {
            
            NavigationView {
                
                tabView()
            }
        }
    }
}
