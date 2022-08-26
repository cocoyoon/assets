
import Foundation
import SwiftUI

class MegazineViewModel: ObservableObject {
    
    @Published var all_meagazines: [megazineModel] = [
        
        megazineModel(id: 0, offset: 0, image: "kanye", title: "Kanye Donda Album & Margila & Vetements"),
        megazineModel(id: 1, offset: 0, image: "sun", title: "Photograph by Photographer"),
        megazineModel(id: 2, offset: 0, image: "supreme", title: "Supreme The Best Season"),
        megazineModel(id: 3, offset: 0, image: "carti", title: "Why he so MAD!")
    ]
}
