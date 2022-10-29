
import UIKit

class SettingsViewController: CustomViewController {
    override var nameViewControler: String { "НАСТРОЙКИ" }
    private let musicManager = MusicModel()
    private let settingsView = SettingsView()
    private let teams: [Team]
    private let gameWords: [String]

    init(teams: [Team], gameWords: [String]) {
        self.teams = teams
        self.gameWords = gameWords
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.settingsView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.settingsView)
        
        NSLayoutConstraint.activate([
            self.settingsView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.settingsView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.settingsView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.settingsView.topAnchor.constraint(equalTo: self.customNavigationBarView.bottomAnchor, constant: 10.0)
        ])
        
        self.settingsView.buttonHandler = {
            [weak self] in
            guard let self = self else { return }
            
            let vc = ScoreViewController(
                teams: self.teams,
                gameWords: self.gameWords
            )
            self.navigationController?.pushViewController(vc, animated: true)

            self.musicManager.playSound(soundName: "Transition")
        }
    }

}
