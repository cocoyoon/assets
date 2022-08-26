
import Foundation

struct News: Identifiable {
    
    var id: String
    let category: String
    let contents: Int
    let createdAt: Double
    let read: Int
    let tag: [String]
    let title: String
    
    func map() -> String {
        
        switch self.category {
            
        case "브랜드":
            return "brand"
        case "발매정보":
            return "launch"
        default :
            return "exhibition"
        }
    }
}


