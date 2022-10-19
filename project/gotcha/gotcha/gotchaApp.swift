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
    
    @StateObject var AuthVM = AuthViewModel()
    
    init() {
        setupAuthentication()
    }
    var body: some Scene {
        WindowGroup {
            SwitchView()
                .environmentObject(AuthVM)
        }
    }
}

extension gotchaApp {
    private func setupAuthentication() {
        FirebaseApp.configure()
    }
}
