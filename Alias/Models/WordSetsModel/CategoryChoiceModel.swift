
import UIKit

class CategoryChoiceModel {

    private var levelPages = [
        LevelPageModel(image: "Classic", level: "Классическая игра", color: "SignalOrangeColor", description: "Знакомый формат игры. \nСодержит в себе наборы слов и словосочетаний, сгрупированные по уровню сложности"),
        LevelPageModel(image: "Categories", level: "Тематическая игра", color: "PersianBlueColor", description: "Выбери любимую тему и отгадывай слова! \nСреди категорий: путешествия, наука, слэнг и, конечно, еда!")]
    private var categories = [CategoryModel]()
    private var choice = 0


    func loadCategories(complition: ([CategoryModel]) -> ()) {
        guard let url = Bundle.main.url(forResource: "ClassicSetWords", withExtension: "json") else { return }

        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let categories = try decoder.decode([CategoryModel].self, from: data)
            self.categories = categories
            complition(categories)
        } catch {
            print("error:\(error.localizedDescription)")
        }
    }

    func getLevel() -> LevelPageModel {
        levelPages[self.choice]
    }

    func makeForwardChoice() {
        if self.choice < self.levelPages.count - 1 {
            self.choice += 1
        }
    }

    func makeBackChoice() {
        if self.choice == self.levelPages.count - 1 && self.choice >= 0 {
            self.choice -= 1
        } else  {
            self.choice = 0
        }
    }

    func getWords() -> [String] {
        self.categories[self.choice].words
    }

}
