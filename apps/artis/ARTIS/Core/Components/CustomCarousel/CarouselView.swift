import SwiftUI

struct CarouselView: View {
    
    @GestureState private var dragState = DragState.inactive
    @State var carouselLocation = 0
    
    var itemHeight: CGFloat
    var views: [AnyView]
    var title: [String]
    
    private func onDragEnded(drag: DragGesture.Value) {
        
        let dragThreshold: CGFloat = 200
        
        if drag.predictedEndTranslation.width > dragThreshold || drag.translation.width > dragThreshold{
            
            carouselLocation =  carouselLocation - 1
            
        } else if (drag.predictedEndTranslation.width) < (-1 * dragThreshold) || (drag.translation.width) < (-1 * dragThreshold)
        {
            carouselLocation =  carouselLocation + 1
        }
    }
    
    var body: some View {
        
        ZStack {

            VStack {
                
                ZStack {
                    
                    ForEach(0 ..< views.count){ index in
                        
                        VStack{
                            
                            self.views[index]
                            
                            .frame(width:200, height: self.getHeight(index))
                            .animation(.interpolatingSpring(stiffness: 300.0, damping: 30.0, initialVelocity: 10.0), value: UUID())
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 3)
                            .opacity(self.getOpacity(index))
                            .animation(.interpolatingSpring(stiffness: 300.0, damping: 30.0, initialVelocity: 10.0), value: UUID())
                            .offset(x: self.getOffset(index))
                            .animation(.interpolatingSpring(stiffness: 300.0, damping: 30.0, initialVelocity: 10.0), value: UUID())
                            
                        }.padding()
                    }
                    
                }.gesture(
                    
                    DragGesture()
                        .updating($dragState) { drag, state, transaction in
                            
                            state = .dragging(translation: drag.translation)
                    }
                    .onEnded(onDragEnded)
                )
                
                Spacer()
            }
            
            VStack {

                Spacer().frame(height:itemHeight + 30)
                Text(title[relativeLoc()])
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(Color.theme.TextColor)
                    .padding()
            }
        }
    }
    
    func relativeLoc() -> Int {
        
        return ((views.count * 10000) + carouselLocation) % views.count
    }
    
    func getHeight(_ i:Int) -> CGFloat {
        
        if i == relativeLoc() {
             
            return itemHeight
            
        } else {
            
            return itemHeight - 30
        }
    }

    func getOpacity(_ i:Int) -> Double{
        
        if i == relativeLoc()
            || i + 1 == relativeLoc()
            || i - 1 == relativeLoc()
            || i + 2 == relativeLoc()
            || i - 2 == relativeLoc()
            || (i + 1) - views.count == relativeLoc()
            || (i - 1) + views.count == relativeLoc()
            || (i + 2) - views.count == relativeLoc()
            || (i - 2) + views.count == relativeLoc()
        {
            return 1
            
        } else {
            
            return 0
        }
    }
    
    func getOffset(_ i:Int) -> CGFloat {
        
        if i == relativeLoc() {
            
            
            return self.dragState.translation.width
            
        } else if i == relativeLoc() + 1 || (relativeLoc() == views.count - 1 && i == 0) {
            
            
            return self.dragState.translation.width + (200 + 20)
            
        } else if i == relativeLoc() - 1 || (relativeLoc() == 0 && i == views.count - 1) {
            
            
            return self.dragState.translation.width - (200 + 20)
            
        } else if i == relativeLoc() + 2 || (relativeLoc() == views.count - 1 && i == 1) || (relativeLoc() == views.count - 2 && i == 0) {
            
           
            return self.dragState.translation.width + (2 * (200 + 20))
            
        } else if i == relativeLoc() - 2 || (relativeLoc() == 1 && i == views.count - 1) || (relativeLoc() == 0 && i == views.count - 2) {
            
            
            return self.dragState.translation.width - (2 * (200 + 20))
            
        } else if i == relativeLoc() + 3 || (relativeLoc() == views.count-1 && i == 2) || (relativeLoc() == views.count-2 && i == 1) || (relativeLoc() == views.count-3 && i == 0) {
            
            
            return self.dragState.translation.width + (3 * (300 + 20))
            
        } else if i == relativeLoc() - 3 || (relativeLoc() == 2 && i == views.count-1) || (relativeLoc() == 1 && i == views.count - 2) || (relativeLoc() == 0 && i == views.count - 3) {
            
            
            return self.dragState.translation.width - (3 * (200 + 20))
        } else {
            
            return 10000
        }
    }
}

enum DragState {
    
    case inactive
    case dragging(translation: CGSize)
    
    var translation: CGSize {
        
        switch self {
            
        case .inactive:
            
            return .zero
            
        case .dragging(let translation):
            
            return translation
        }
    }
    
    var isDragging: Bool {
        
        switch self {
            
        case .inactive:
            
            return false
            
        case .dragging:
            
            return true
        }
    }
}


