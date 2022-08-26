//
//  lastPageView.swift
//  ARTIS
//
//  Created by 정소윤 on 2021/12/06.
//

import SwiftUI

struct LastPageView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @ObservedObject var vm: LastPageViewModel
    @StateObject var imageVM: NewsImageViewModel
    @State private var showPurchaseView: Bool = false
    
    private let news: News
    private let db_collection: String
    
    init(news: News, db_collection: String) {
        
        self.news = news
        self.db_collection = db_collection
        self.vm = LastPageViewModel(news: news)
        _imageVM = StateObject(wrappedValue: NewsImageViewModel(news: news))
    }
    
    var body: some View {
        
        switch db_collection {
            
        case "ex_info":
            ExhibitionLastPageView
                .sheet(isPresented: $showPurchaseView) {
                    
                    vm.getInfo(db_collection)
                } content: {
                    
                    PurchaseView(isPresented: $showPurchaseView)
                }
            
        case "launch_info":
            Text("발매정보")
                .onTapGesture {
                    
                    presentationMode.wrappedValue.dismiss()
                } // View need to be handeld
        default:
            Text("브랜드")
                .onTapGesture {
                    
                    presentationMode.wrappedValue.dismiss()
                } // View need to be handeld
        }
    }
}

struct lastPageView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        LastPageView(news: dev.news, db_collection: "ex_info")
    }
}

extension LastPageView {
    
    private var ExhibitionLastPageView: some View {
        
        ScrollView(showsIndicators: false) {
            
            if let info = vm.ex_info {
                
                VStack {
                    
                    HStack {
                        
                        Spacer()
                        
                        Button {
                            imageVM.removeContentsImageFromCache() 
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            
                            Image(systemName: "xmark")
                                .foregroundColor(Color.theme.TextColor)
                                .font(.title2)
                        }
                    }
                    .padding(.top)

                    // header
                    VStack(spacing: 5) {
                        
                        HStack {
                            
                            Text(info.title)
                                .font(.title)
                                .fontWeight(.bold)
                            
                            Text(info.isProgress ? "전시중" : "전시종료")
                                .foregroundColor(Color.theme.background)
                                .font(.caption)
                                .fontWeight(.bold)
                                .padding()
                                .background(
                                    
                                    Rectangle()
                                        .cornerRadius(20)
                                        .foregroundColor(Color.theme.TextColor)
                                        .frame(width: 60, height: 20, alignment: .center)
                                )
                            
                            Spacer()
                        } // header
                        
                        HStack {
                            
                            Image(colorScheme == .light ? "insta_light" : "insta_dark")
                                .resizable()
                                .frame(width:20,height:20)
                                .foregroundColor(Color.theme.TextColor)
                            
                            Text(info.sns)
                                .font(.body)
                                .fontWeight(.semibold)
                            
                            Spacer()
                        } // instagram
                        .frame(maxHeight: 30)
                        .padding(.bottom)
                    }
                    
                    // Summary
                    VStack {
                        
                        HStack {
                            
                            Text("전시회 요약")
                                .font(.title2)
                                .fontWeight(.bold)
                            Spacer()
                        }
                        
                        ZStack {
                            
                            RoundedRectangle(cornerRadius:10)
                                .frame(height: UIScreen.main.bounds.width/2)
                                .foregroundColor(Color.gray.opacity(0.2))
                            
                            HStack {
                                
                                if let image = imageVM.coverImage {
                                    
                                    Image(uiImage: image)
                                        .resizable()
                                        .aspectRatio(CGSize(width: 1.4,height:1.6), contentMode: .fit)
                                        .cornerRadius(10)
                                        .padding(.top)
                                        .padding(.bottom)
                                        .padding(.leading)
                                    
                                    // info section
                                    VStack(alignment: .leading) {
                                        
                                        HStack {
                                            
                                            Text("작가")
                                                .font(.caption)
                                                .fontWeight(.bold)
                                            Spacer()
                                            Text(info.artist)
                                                .font(.caption)
                                                .fontWeight(.bold)
                                                .padding(.trailing)
                                        }
                                        
                                        Spacer()
                                        
                                        HStack(alignment:.top, spacing: 8) {
                                            
                                            Text("전시 기간")
                                                .font(.caption)
                                                .fontWeight(.bold)
                                            
                                            VStack(spacing:0) {
                                                
                                                Text("\(Date(timeIntervalSince1970: info.period["from"] ?? 0.0).format)")
                                                    .font(.system (size: 10))
                                                    .font(.caption)
                                                    .fontWeight(.bold)
                                                
                                                Text("\(Date(timeIntervalSince1970: info.period["to"] ?? 0.0).format)")
                                                    .font(.system (size: 10))
                                                    .font(.caption)
                                                    .fontWeight(.bold)
                                            }
                                        }
                                        
                                        Spacer()
                                        
                                        HStack {
                                            
                                            Text("전시 장소")
                                                .font(.caption)
                                                .fontWeight(.bold)
                                            Spacer()
                                            Text("\(info.location)")
                                                .font(.caption)
                                                .fontWeight(.bold)
                                                .padding(.trailing)
                                        }
                                        
                                        Spacer()
                                        
                                        // Booking Button
                                        HStack(spacing: 5) {
                                            
                                            ZStack(alignment:.center) {
                                                
                                                RoundedRectangle(cornerRadius: 10)
                                                    .foregroundColor(Color("myColor"))
                                                    .frame(height: 30)
                                                
                                                Text("에매하기")
                                                    .font(.caption)
                                                    .fontWeight(.bold)
                                                    .foregroundColor(Color.white)
                                                    .padding()
                                                    .onTapGesture {
                                                        
                                                        self.showPurchaseView.toggle()
                                                    }
                                            }
                                            
                                            Spacer()
                                            
                                            HStack {
                                                
                                                Image(systemName: "square.and.arrow.up")
                                                    .font(.subheadline)
                                                    .foregroundColor(Color.theme.MainColor)
                                                
                                                Image(systemName: "bookmark")
                                                    .font(.subheadline)
                                                    .foregroundColor(Color.theme.MainColor)
                                            }
                                        }
                                    }
                                    .padding()
                                    Spacer()
                                } else if imageVM.isLoading {
                                    
                                    ProgressView()
                                } else {
                                    
                                    Image(systemName: "questionMark")
                                        .foregroundColor(Color.theme.TextColor)
                                }
                            }
                            .onAppear {
                                
                                imageVM.downloadCoverImage()
                            }
                        }
                        .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.width/2)
                    }
                    
                    // Score
                    VStack {
                        
                        HStack {
                            
                            Text("전시회 평점")
                                .font(.title2)
                                .fontWeight(.bold)
                            
                            Spacer()
                        }
                        
                        ZStack {
                            
                            Rectangle()
                                .foregroundColor(Color.gray.opacity(0.2))
                                .cornerRadius(10)
                                .frame(height: UIScreen.main.bounds.width/4)
                            
                            VStack(spacing: 10) {
                                
                                Text("\(info.score.formatted())")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                
                                Text(info.score_comment())
                                    .font(.caption)
                                    .fontWeight(.bold)
                            }
                        }
                        .frame(maxHeight: UIScreen.main.bounds.width/4)
                    }
                    .padding(.top)
                    
                    // Review
                    VStack {
                        
                        HStack {
                            
                            Text("전시회 리뷰")
                                .font(.title2)
                                .fontWeight(.bold)
                            
                            Spacer()
                        }
                        
                        ZStack {
                            
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(Color.gray.opacity(0.2))
                                .frame(height: UIScreen.main.bounds.width/1.5)
                            
                            ScrollView(.horizontal) {
                                
                                HStack {
                                    
                                    ForEach(1...5, id: \.self) { _ in
                                        
                                        RoundedRectangle(cornerRadius: 10)
                                            .foregroundColor(Color.gray.opacity(0.3))
                                            .frame(width: UIScreen.main.bounds.width/1.8, height: UIScreen.main.bounds.width/1.8)
                                    }
                                }
                            }
                            .padding()
                        }
                        .frame(maxHeight: UIScreen.main.bounds.width/1.5)
                    }
                    .padding(.top)
                }
                .padding()
            } else {
                
                ProgressView()
            }
        }
        .padding(.top,20)
        .onAppear {
            
            vm.getInfo(db_collection)
        }
    }
}
