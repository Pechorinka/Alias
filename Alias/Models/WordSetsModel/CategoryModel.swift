
import Foundation

struct CategoryModel: Codable {
    let title: String
    let image: String
    let color: String
    let description: String
    let example: String
    let words: [String]
}

extension CategoryModel {
    
    var isMixCategory: Bool {
        self.title.lowercased() == "микс"
    }
    
}

