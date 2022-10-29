
import UIKit

class CategoryChoiceModel {
    private lazy var workerQueue = DispatchQueue(label: "categoryChoiceModel.worker.queue")

    enum WordSetType: String {
        case classic = "ClassicSetWords"
        case theme = "ThemeSetWords"
    }

    private var levelPages = [
        LevelPageModel(image: "Classic",
                       level: "Классическая игра",
                       color: "PersianBlueColor",
                       description: "Знакомый формат игры. \nСодержит в себе наборы слов и словосочетаний, сгруппированные по уровню сложности"),
        LevelPageModel(image: "Theme",
                       level: "Тематическая игра",
                       color: "SignalOrangeColor",
                       description: "Выбери любимую тему и отгадывай слова! \nСреди категорий: путешествия, наука, слэнг и, конечно, еда!")]
    
    private var categories = [CategoryModel]()
    private var choice = 0
    private(set) var wordsSetType: WordSetType?

    func loadCategories(wordsSetType: WordSetType, completion: @escaping ([CategoryModel]) -> Void) {
        guard let url = Bundle.main.url(forResource: wordsSetType.rawValue, withExtension: "json") else {
            completion([])
            return
        }
        
        self.wordsSetType = wordsSetType
        
        self.workerQueue.async {
            Thread.sleep(forTimeInterval: 0.5)
            
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let categories = try decoder.decode([CategoryModel].self, from: data)
                self.categories = categories
                
                DispatchQueue.main.async {
                    completion(categories)
                }
            } catch {
                print("error:\(error.localizedDescription)")
                
                DispatchQueue.main.async {
                    completion([])
                }
            }
        }
    }
    
    func getLevel() -> LevelPageModel {
        levelPages[self.choice]
    }

    func makeForwardChoice() {
        if self.choice < self.levelPages.count - 1 {
            self.choice += 1
        } else {
            self.choice = 0
        }
    }

    func makeBackChoice() {
        if self.choice == self.levelPages.count - 1 {
            self.choice -= 1
        } else  {
            self.choice = 1
        }
    }

    func getWords(set: Set<Int>) -> [String] {
        var words = [String]()
        
        if self.isMixCategoryChoosen(set) {
            for category in categories {
                words += category.words
            }
        } else {
            set.forEach { words.append(contentsOf: self.categories[$0].words) }
        }
        
        print("words.count: \(words.count)")
        return words
    }
    
    func isMixCategoryChoosen(_ set: Set<Int>) -> Bool {
        self.wordsSetType == .theme &&
        set.contains(self.categories.count - 1)
    }
}
