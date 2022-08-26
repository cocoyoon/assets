//
//  SearchView.swift
//  SearchView
//
//  Created by 정소윤 on 2021/09/23.
//

import SwiftUI

struct SearchView: View {
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @ObservedObject var vm: SearchViewModel = SearchViewModel()
//    @StateObject var imageVM: NewsImageViewModel
    @State private var isSearching: Bool = false
    
    var body: some View {
        
        VStack{
            
            searchBarView
            
            Divider()
            
            if isSearching {
                
                recentSearchView
            } else {
                
                newsView
            }
        }
        .navigationTitle("검색하기")
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        
        SearchView()
    }
}

extension SearchView {
    
    private var searchBarView: some View {
        
        HStack {
            
            HStack {
                
                Image(systemName: "magnifyingglass")
                    .foregroundColor(vm.textSearch.isEmpty ? Color.gray.opacity(0.5) : Color.theme.TextColor)
                
                TextField("발매 정보, 전시회, 브랜드 검색하기", text: $vm.textSearch)
                    .foregroundColor(Color.theme.TextColor)
                    .overlay(
                        
                        Image(systemName: "xmark.circle.fill")
                            .padding()
                            .offset(x: 10)
                            .opacity(vm.textSearch.isEmpty ? 0.0 : 1.0)
                            .onTapGesture {
                                
                                self.isSearching = false
                                UIApplication.shared.endEditing()
                                vm.textSearch = ""
                            }
                        
                        ,alignment: .trailing
                    )
            }
            .onTapGesture {
                withAnimation(.spring()) {
                    self.isSearching = true
                }
            }
            .padding()
            .background(
                
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.theme.newsColor)
            )
            .padding()
            
            if isSearching {
                
                Text("cancel")
                    .foregroundColor(Color.theme.TextColor)
                    .fontWeight(.semibold)
                    .transition(.move(edge: .trailing))
                    .onTapGesture {
                        UIApplication.shared.endEditing()
                        self.isSearching = false
                        vm.textSearch = ""
                    }
                    .padding(.trailing,20)
            }
        }
    }
    
    private var newsView: some View {
        
        ScrollView {
            
            VStack(alignment: .leading) {
                
                HStack {
                    
                    Text("검색 키워드  👀")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding()
                    
                    Spacer()
                }
                
                VStack {
                    
                    Text("dummy")
                        .foregroundColor(Color.theme.TextColor)
                        .font(.subheadline)
                        .fontWeight(.bold)
                    Text("dummy")
                        .foregroundColor(Color.theme.TextColor)
                        .font(.subheadline)
                        .fontWeight(.bold)
                    Text("dummy")
                        .foregroundColor(Color.theme.TextColor)
                        .font(.subheadline)
                        .fontWeight(.bold)
                }
                .padding(.horizontal)
            }
            
            HStack {
                
                Text("트렌드 뉴스  🔥")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding()
                
                Spacer()
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                
                LazyHStack {
                    
                    ForEach(vm.trendNews) { news in
                        
                        let imageVM = NewsImageViewModel(news: news)
                        
                        if let image = imageVM.coverImage {
                            
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(CGSize(width: 1.2, height: 1.4), contentMode: .fit)
                                .cornerRadius(20)
                                .padding(.horizontal)
                            
                        } else if imageVM.isLoading {
                            
                            ProgressView()
                        } else {
                            
                            Text("Error Loading Images! ⚠️")
                        }
                    }
                }
                .frame(height: 200)
            }
        }
    }
    
    private var recentSearchView: some View {
        
        ScrollView {
            
            if vm.textSearch.isEmpty {
                
                HStack {
                    
                    Text("최근 검색")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding()
                    
                    Spacer()
                }
            } else {
                
                ForEach(vm.filteredNews) { news in
                    
                    NewsRowView(news: news)
                }
            }
        }
    }
}
