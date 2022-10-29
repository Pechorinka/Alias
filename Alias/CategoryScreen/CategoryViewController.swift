import UIKit
import SkeletonView

class CategoryViewController: CustomViewController {
    override var nameViewControler: String { "НАБОРЫ" }
    
    private let viewModel = CategoryChoiceModel()
    
    private var wordSet: CategoryChoiceModel.WordSetType
    private lazy var categoryView = CategoryView(viewModel: self.viewModel)
    private lazy var teams = [Team]()
    
    init(
        teams: [Team],
        wordSet: CategoryChoiceModel.WordSetType
    ) {
        self.wordSet = wordSet
        super.init(nibName: nil, bundle: nil)
        self.teams = teams
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.isSkeletonable = true
        self.categoryView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.categoryView)
        
        self.viewModel.loadCategories(wordsSetType: self.wordSet) {
            [weak self] categories in
            self?.categoryView.categories = categories
        }

        NSLayoutConstraint.activate([
            self.categoryView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.categoryView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.categoryView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.categoryView.topAnchor.constraint(equalTo: self.customNavigationBarView.bottomAnchor, constant: 5)
        ])
        
        self.categoryView.nextVC = {
            [weak self] in
            guard let self = self else { return }
            
            let gameWords = self.viewModel.getWords(set: self.categoryView.cellSet)
            let vc = SettingsViewController(
                teams: self.teams,
                gameWords: gameWords
            )
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

