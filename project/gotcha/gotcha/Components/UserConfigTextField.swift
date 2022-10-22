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
    
    @State private var userText: String = ""
    @State private var showNextButton: Bool = false
    
    var body: some View {
        
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
                    
                    Image(systemName: "arrow.right.square.fill")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(Color.theme.MainText)
                        .onTapGesture {
                            ()
                        }
                        .padding(.trailing, 40)
                        .transition(.slide)
                }
            }
        }
    }
}

struct UserConfigSetting_Previews: PreviewProvider {
    static var previews: some View {
        UserConfigTextField()
            .preferredColorScheme(.dark)
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

