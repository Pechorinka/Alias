
import UIKit

final class GameKitViewController: CustomViewController {

    override var nameViewControler: String { "КАТЕГОРИИ" }
    private lazy var gameKitViuw = GameKitView()
    private lazy var difficultyChoiceModel = CategoryChoiceModel()
    private let musicManager = MusicModel()
    lazy var teams = [Team]()
//    lazy var gameWords: [String] = self.difficultyChoiceModel.getWords()

    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.gameKitViuw.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.gameKitViuw)
        
        NSLayoutConstraint.activate([
            self.gameKitViuw.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.gameKitViuw.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.gameKitViuw.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.gameKitViuw.topAnchor.constraint(equalTo: self.customNavigationBarView.bottomAnchor, constant: 5)
        ])
        self.gameKitViuw.delegate = self
        self.updateUI()
    }

    private func updateUI() {
        let update = self.difficultyChoiceModel.getLevel()
        let image = update.image
        let color = update.color

        self.gameKitViuw.choiceImageView.image = UIImage(named: image)
        self.gameKitViuw.levelLabel.textColor = UIColor(named: color)
        self.gameKitViuw.levelLabel.text = update.level
        self.gameKitViuw.descriptionLabel.text = update.description
    }
}

// MARK: - TapButtonDelegate

extension GameKitViewController: TapButtonDelegate {
    
    func didForwardChoice() {
        self.difficultyChoiceModel.makeForwardChoice()
        self.musicManager.playSound(soundName: "Transition")
//        self.gameWords = self.difficultyChoiceModel.getWords()
        self.updateUI()
    }

    func didBackChoice() {
        self.difficultyChoiceModel.makeBackChoice()
        self.musicManager.playSound(soundName: "Transition")
//        self.gameWords = self.difficultyChoiceModel.getWords()
        self.updateUI()
    }

    func didMakeChoice() {
//        let vc = ScoreViewController(
//            teams: self.teams,
//            gameWords: self.gameWords
//        )

        let vc = CategoryViewController()
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
