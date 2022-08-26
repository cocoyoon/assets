//
//  purchaseView.swift
//  ARTIS
//
//  Created by 정소윤 on 2021/12/07.
//

import SwiftUI

struct PurchaseView: View {
    
    @Binding var isPresented: Bool
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            HStack {
                
                Text("결제하기")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color.theme.TextColor)
                
                Spacer()
            }
            .padding()
            .padding(.top,10)
            
            Spacer()
        }
        .padding()
    }
}

struct purchaseView_Previews: PreviewProvider {
    static var previews: some View {
        PurchaseView(isPresented: .constant(true))
    }
}
