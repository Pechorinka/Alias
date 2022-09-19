
import UIKit

class StartMenuViewController: UIViewController {
    
    private let startMenuView = StartMenuView()

    override func loadView() {
        self.view = self.startMenuView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startMenuView.rulesMenuButtonTap = {
            [weak self] in
            guard let self = self else { return }
            let vc = RulesViewOnebording(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }
        
        startMenuView.newGameButtonTap = {
            [weak self] in
            guard let self = self else { return }
            let vc = TeamsMenuViewController(minNumberOfTeams:2, maxNumberOfTeams: 10)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

class Core {
    static let shared = Core()
    
    private init() {
        UserDefaults.standard.register(defaults: ["IsFirstAppStartup": true])
    }
    
    var isFirstAppStartup: Bool {
        UserDefaults.standard.bool(forKey: "IsFirstAppStartup")
    }
    
    func setIsNotFirstAppStartup() {
        UserDefaults.standard.set(false, forKey: "IsFirstAppStartup")
    }
}
