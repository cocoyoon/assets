//
//  image.swift
//  ARTIS
//
//  Created by 정소윤 on 2021/12/12.
//

import SwiftUI

struct image: View {
    
    @StateObject var imageVM: NewsImageViewModel
    @State private var num: Int = 1
    
    init() {
        
        _imageVM = StateObject(wrappedValue: NewsImageViewModel(news: News(id: "yLKoBLXUQDNFWdiCDecd", category: "발매정보", contents: 3, createdAt: 1638258792, read: 0, tag: ["루이비통"], title: "루이비통 x Loucien Clark")))
    }
    var body: some View {
        
        if let image = imageVM.contentsImages {
            
            VStack {
                
                Image(uiImage: image)
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: 500)
                    .cornerRadius(20)
                    .padding()

                HStack {
                    
                    Text("Next")
                        .foregroundColor(.white)
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding()
                        .background(
                            
                            Rectangle()
                                .cornerRadius(10)
                                .foregroundColor(.green)
                        )
                        .onTapGesture {
                            num += 1
                            imageVM.downloadContentsImage(num)
                        }
                        .padding()
                    
                    Text("Remove")
                        .foregroundColor(.white)
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding()
                        .background(
                            
                            Rectangle()
                                .cornerRadius(10)
                                .foregroundColor(.red)
                        )
                        .onTapGesture {
                            imageVM.removeContentsImageFromCache()
                        }
                }
            }
        } else {
            
            ProgressView()
                .onAppear {
                    imageVM.downloadContentsImage(num)
                    imageVM.downloadContentBackground(contentNum: 3)
                }
        }
    }
}

struct image_Previews: PreviewProvider {
    static var previews: some View {
        image()
    }
}
