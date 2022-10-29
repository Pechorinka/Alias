
import UIKit

final class GameKitViewController: CustomViewController {

    override var nameViewControler: String { "КАТЕГОРИИ" }
    private lazy var gameKitViuw = GameKitView()
    private lazy var choiceModel = CategoryChoiceModel()
    private let musicManager = MusicModel()
    lazy var teams = [Team]()

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
        let update = self.choiceModel.getLevel()
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
        self.choiceModel.makeForwardChoice()
        self.musicManager.playSound(soundName: "Transition")
        self.updateUI()
    }

    func didBackChoice() {
        self.choiceModel.makeBackChoice()
        self.musicManager.playSound(soundName: "Transition")
        self.updateUI()
    }

    func didMakeChoice() {

        let wordSet: CategoryChoiceModel.WordSetType

        if gameKitViuw.choiceImageView.image == UIImage(named: "Classic") {
            wordSet = .classic
        } else {
            wordSet = .theme
        }
        let vc = CategoryViewController(teams: self.teams, wordSet: wordSet)
        navigationController?.pushViewController(vc, animated: true)
    }
}
