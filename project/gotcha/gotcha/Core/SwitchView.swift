//
//  SwitchView.swift
//  gotcha
//
//  Created by SoYoun Jeong on 2022/10/20.
//

import SwiftUI

struct SwitchView: View {
    
    @EnvironmentObject var GoogleAuthManager: GoogleAuth
    
    var body: some View {
        switch GoogleAuthManager.state {
            case .signedIn: TabView()
            case .signedOut: LogInView()
            case .newUser: UserConfigView()
        }
    }
}

struct SwitchView_Previews: PreviewProvider {
    static var previews: some View {
        SwitchView()
            .environmentObject(GoogleAuth())
    }
}

