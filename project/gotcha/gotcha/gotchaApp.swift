//
//  gotchaApp.swift
//  gotcha
//
//  Created by SoYoun Jeong on 2022/10/18.
//

import SwiftUI
import Firebase
import GoogleSignIn
    
@main
struct gotchaApp: App {
    
    @StateObject var GoogleAuthManager = GoogleAuth()
    
    init() {
        setupAuthentication()
    }
    var body: some Scene {
        WindowGroup {
            SwitchView()
                .environmentObject(GoogleAuthManager)
        }
    }
}

extension gotchaApp {
    private func setupAuthentication() {
        FirebaseApp.configure()
    }
}
