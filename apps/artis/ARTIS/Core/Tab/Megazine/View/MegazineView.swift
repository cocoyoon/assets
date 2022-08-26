
import SwiftUI

struct MegazineView: View {
    
    @ObservedObject var vm: MegazineViewModel = MegazineViewModel()
    
    var body: some View {
        
        cardMegazine
    }
}

struct MegazineView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        MegazineView()
            .navigationTitle("카드 메거진")
    }
}

extension MegazineView {
    
    private var cardMegazine: some View {
        
        VStack {
            
            Spacer()
            
            Text("Megazine View")
                .font(.largeTitle)
            
            Spacer()
        }
    }
}
