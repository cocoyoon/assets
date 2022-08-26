
import Foundation
import SwiftUI

struct megazineModel: Identifiable {
    
    let id: Int
    var offset: CGFloat
    let image: String
    let title: String
    
    func updateOffset(changedOffset: CGFloat) -> megazineModel {
        
        return megazineModel(id: id, offset: changedOffset, image: image, title: title)
    }
}
