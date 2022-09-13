
import Foundation

//struct WordSetsModels: Codable {
//    let level: [CategoryModel]
//}

struct CategoryModel: Codable {
    let title: String
    let image: String
    let color: String
    let description: String
    let example: String
    let words: [String]
}

