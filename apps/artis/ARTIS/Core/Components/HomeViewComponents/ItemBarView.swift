
import SwiftUI

struct ItemBarView: View {
    
    @Binding var selectedItem: String
    @ObservedObject var vm: HomeViewModel = HomeViewModel()
    
    var item: String
    var animation: Namespace.ID
    
    var body: some View {
        
        Button(action: {
            
            withAnimation(.spring()){selectedItem = item}
        }) {
            
            ZStack(alignment: .bottom) {
                
                Text(item)
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(selectedItem == item ? Color.theme.background : Color.theme.TextColor)
                    .padding(8)
                    .background(
                        ZStack {
                            
                            if selectedItem == item {
                                
                                Rectangle()
                                    .fill(Color.theme.MainColor)
                                    .cornerRadius(10)
                                    .matchedGeometryEffect(id: "ID", in: animation)
                            }
                        }
                    )
            }
        }
    }
}

//struct ItemBarView_Previews: PreviewProvider {
//
//    static var previews: some View {
//
//        ItemBarView(selectedItem: .constant("발매 정보"), item: "발매 정보")
//            .previewLayout(.sizeThatFits)
//    }
//}
