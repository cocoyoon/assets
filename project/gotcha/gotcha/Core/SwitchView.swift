//
//  SwitchView.swift
//  gotcha
//
//  Created by SoYoun Jeong on 2022/10/20.
//

import SwiftUI

struct SwitchView: View {
    
    @EnvironmentObject var AuthVM: AuthViewModel
    
    var body: some View {
        switch AuthVM.state {
            case .signedIn: TabView()
            case .signedOut: LaunchView()
        }
    }
}

struct SwitchView_Previews: PreviewProvider {
    static var previews: some View {
        SwitchView()
            .environmentObject(AuthViewModel())
    }
}
