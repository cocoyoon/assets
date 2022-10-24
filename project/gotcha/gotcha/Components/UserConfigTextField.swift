//
//  UserSettingView.swift
//  gotcha
//
//  Created by SoYounJeong on 2022/10/21.
//

/*
 Check List
 [] GOTCHA ID duplicate check
 */

import SwiftUI

struct UserConfigTextField: View {
    
    @EnvironmentObject var GoogleAuthManager: GoogleAuth
    @State private var userText: String = ""
    @State private var showNextButton: Bool = false
    @State private var isLoading: Bool = false
    
    var body: some View {
        
        if isLoading {
            ProgressView()
        } else {
            VStack(alignment: .leading, spacing: 0) {
                
                Text("닉네임을 설정해주세요 🙂")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(Color.theme.MainText)
                    .padding(.leading, 30)
                    .padding(.bottom, 30)
                    
                HStack {
                    TextField(
                        "입력하기",
                        text: $userText
                    )
                    .foregroundColor(Color.theme.MainText)
                    .textFieldStyle(UnderlineTextFieldStyle())
                    .padding(.leading, 30)
                    .padding(.trailing, 30)
                    .onTapGesture {
                        withAnimation {
                            showNextButton = true
                        }
                    }
                    
                    if showNextButton {
                        
                        Button {
                            isLoading = true
                            NetworkManager.writeDataFS(collectionName: "users", data: ["nick": userText]) {
                                GoogleAuthManager.setSignedIn()
                            }
                        } label: {
                            Image(systemName: "arrow.right.square.fill")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(Color.theme.MainText)
                                .padding(.trailing, 40)
                                .transition(.slide)
                        }
                    }
                }
            }
        }
    }
}

struct UserConfigSetting_Previews: PreviewProvider {
    static var previews: some View {
        UserConfigView()
    }
}


struct UnderlineTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(.vertical, 8)
            .font(.title)
            .background(
                VStack {
                    Spacer()
                    Color.theme.Signature.frame(height: 2)
                }
            )
            .textInputAutocapitalization(TextInputAutocapitalization.never)
            .autocorrectionDisabled(true)
    }
}

