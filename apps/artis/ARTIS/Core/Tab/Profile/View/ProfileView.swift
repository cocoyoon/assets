//
//  ProfileView.swift
//  ProfileView
//
//  Created by 정소윤 on 2021/09/23.
//

import SwiftUI

struct ProfileView: View {
     
    @ObservedObject var vm: HomeViewModel = HomeViewModel() // dummy view model
    var ExhibitionItem: [String] = ["picasso","lab","yoshigo","beyond"] //dummy data
    
    var body: some View {
        
        ScrollView {
            
            profileHeader

            VStack {
                
                exHighlight
                
                Divider()
                
                savedList
            }
        }
        .navigationTitle("")
        .navigationBarHidden(true)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

extension ProfileView {
    
    private var profileHeader: some View {
        
        VStack {
            
            VStack(alignment: .center) {
                
                ZStack {
                    
                    Circle()
                        .frame(width: UIScreen.main.bounds.width/4+3, height: UIScreen.main.bounds.width/4+3)
                        .foregroundColor(Color.theme.MainColor)
                    
                    Image("me")
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width/4,height: UIScreen.main.bounds.width/4)
                        .clipShape(Circle())
                        .onTapGesture {
                            
                            // do something.. maybe profile change..?
                        }
                }
                
                Text("Yoon")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.top,10)
                
                Text("패션, 음악, 컬처")
                    .font(.footnote)
                    .padding(.top,3)
                    .padding(.bottom,UIScreen.main.bounds.width/9)
                
                Divider()
                
            }
        }.padding(.top,UIScreen.main.bounds.width/9)
    }
    
    @ViewBuilder
    private var exHighlight: some View {
        
        HStack {
            
            Text("전시회 하이라이트")
                .font(.title2)
                .fontWeight(.bold)
            
            Spacer()
            
            Image(systemName: "plus.circle")
                .foregroundColor(Color.theme.MainColor)
                .onTapGesture {
                    
                    //do something. add exhibition photo
                }

        }
        .padding()
        
        ScrollView(.horizontal, showsIndicators: false) {
             
            VStack {
                
                HStack {
                    
                    ForEach(ExhibitionItem, id: \.self) { ex in
                        
                        VStack {
                            
                            Circle()
                                .frame(width: UIScreen.main.bounds.width/7+3, height: UIScreen.main.bounds.width/7+3)
                                .foregroundColor(Color.theme.MainColor)
                                .overlay(
                                    
                                    Image(ex)
                                        .resizable()
                                        .frame(width: UIScreen.main.bounds.width/7 ,height: UIScreen.main.bounds.width/7)
                                        .clipShape(Circle())
                                )

                            Text(ex)
                                .font(.footnote)
                                .fontWeight(.bold)
                        }
                    }.padding(.horizontal,5)
                }.padding(.horizontal)
            }
        }.padding(.bottom)
    }
    
    private var savedList: some View {
        
        VStack {
            
            HStack {
                
                Text("저장한 리스트")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Spacer()

            }
        }.padding()
    }
}
