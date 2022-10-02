
import UIKit

class CategoryChoiceModel {

    enum WordSet: String {
        case classic = "ClassicSetWords"
        case theme = "ThemeSetWords"
    }

    private var levelPages = [
        LevelPageModel(image: "Classic", level: "Классическая игра", color: "PersianBlueColor", description: "Знакомый формат игры. \nСодержит в себе наборы слов и словосочетаний, сгруппированные по уровню сложности"),
        LevelPageModel(image: "Theme", level: "Тематическая игра", color: "SignalOrangeColor", description: "Выбери любимую тему и отгадывай слова! \nСреди категорий: путешествия, наука, слэнг и, конечно, еда!")]
    private var categories = [CategoryModel]()
    private var choice = 0


    func loadCategories(words: WordSet) -> [CategoryModel] {
        if let url = Bundle.main.url(forResource: words.rawValue, withExtension: "json") {

            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let categories = try decoder.decode([CategoryModel].self, from: data)
                self.categories = categories
            } catch {
                print("error:\(error.localizedDescription)")
            }
        }
        return categories
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

    func getWords() -> [String] {
        self.categories[self.choice].words
    }

}
