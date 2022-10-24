//
//  UserConfigViewModel.swift
//  gotcha
//
//  Created by SoYoun Jeong on 2022/10/23.
//

import Foundation

class UserConfigViewModel: ObservableObject {
    
    @Published var configStatus: UserConfigStatus = .nick
    
    enum UserConfigStatus {
        case nick
        case complete
    }
    
    func setStatusComplete() {
        self.configStatus = .complete
    }
}
