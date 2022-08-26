
import SwiftUI

struct tabView: View {
    
    @State var selectedTab: Int = 0
    @State var isTabShow: Bool = true
    
    private let vm: TabViewModel = TabViewModel()

    var body: some View {
        
        ZStack {
            
            Color.theme.background
                .ignoresSafeArea()
            
            VStack(spacing:0) {
                
                TabSwitchView
                
                Divider()
                
                TabBarView
            }
            .ignoresSafeArea(.keyboard)
        }
    }
}

struct tabView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        tabView()
    }
}

extension tabView {
    
    private var TabSwitchView: some View {
        
        ZStack {
            
            switch selectedTab {
                
            case 0:
                
                HomeView()
                
            case 1:
                
                MegazineView()
                    .navigationTitle("메거진")
            
            case 2:
        
                SearchView()
                    .navigationTitle("검색하기")

            default:
                
                ProfileView()
            }
        }
    }
    
    private var TabBarView: some View {
        
        HStack(spacing: 20) {
            
            ForEach(0 ..< 4 , id: \.self) { (tag) in
                
                Spacer()
                
                VStack(spacing: 5) {
                    
                    Image(systemName: selectedTab == tag ? vm.Item[tag].selectedImage : vm.Item[tag].defaultImage)
                        .font(.system(size: 15,
                                      weight: selectedTab == tag ? .bold : .medium,
                                      design: .default))
                        .foregroundColor(Color.theme.TextColor)
                    
                    Text(vm.Item[tag].name)
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.theme.TextColor)
                }
                .onTapGesture {
                    
                    self.selectedTab = tag
                }
            }
            
            Spacer()
        }
        .padding(.top,10)
    }
}
