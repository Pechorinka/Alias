import Foundation

class RulesModel {
    
    let models = RulesModel.loadRulesModel()
    
    static func loadRulesModel() -> [RuleModel] {
        guard let modelURL = Bundle.main.url(forResource: "RulesData", withExtension: "plist") else { return [] }
        var models = [RuleModel]()
        
        do {
            let data = try Data(contentsOf: modelURL)
            let decoder = PropertyListDecoder()
            models = try decoder.decode([RuleModel].self, from: data)
            print("models \(models)")
        } catch {
            print(error)
        }
        
        return models
    }
}
