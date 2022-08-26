
//  alarmView

import SwiftUI

struct AlarmView: View {
    
    let imageName: String
    
    var body: some View {
            
            Image(systemName: imageName)
                .font(.headline)
                .frame(width:40, height: 40)
                .background(
                
                    Circle()
                        .foregroundColor(Color.theme.subBackground)
                )
                .shadow(color: Color.theme.MainColor.opacity(0.4),
                        radius: 10, x: 0, y: 0
                )
    }
}

struct alarmView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        Group {
            
            AlarmView(imageName: "bell")
                .previewLayout(.sizeThatFits)
            
            AlarmView(imageName: "bell")
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
    }
}
