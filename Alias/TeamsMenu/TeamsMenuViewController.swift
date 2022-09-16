
import UIKit

class TeamsMenuViewController: CustomViewController {
    
    private let alertManager = AlertForChangeTeamName()
    override var nameViewControler: String { "КОМАНДЫ" }
    let minNumberOfTeams: Int
    let maxNumberOfTeams: Int
    
    private let musicManager = MusicModel()
    
    var teams: [Team] = [] {
        didSet {
            self.teamsMenuView.teams = self.teams
        }
    }
    
    private lazy var teamsMenuView = TeamsMenuView(
        minNumberOfTeams: self.minNumberOfTeams,
        maxNumberOfTeams: self.maxNumberOfTeams,
        teams: self.teams
    )
    
    private let teamsCreator = Teams()
    
    init(minNumberOfTeams: Int, maxNumberOfTeams: Int) {
        self.minNumberOfTeams = minNumberOfTeams
        self.maxNumberOfTeams = maxNumberOfTeams
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.teamsMenuView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.teamsMenuView)
        
        NSLayoutConstraint.activate([
            self.teamsMenuView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.teamsMenuView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.teamsMenuView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.teamsMenuView.topAnchor.constraint(equalTo: self.customNavigationBarView.bottomAnchor)
        ])
        
        let firstTwoTeams = self.teamsCreator.makeTeams(count: minNumberOfTeams)
        self.teams = firstTwoTeams
        
        self.teamsMenuView.addNewTeam = {
            [weak self] in
            guard let self = self else { return }
            
            self.musicManager.playSound(soundName: "Transition")
           
            guard self.teams.count != self.maxNumberOfTeams else { return }
            
            let newTeam = self.teamsCreator.makeNewTeam()
            self.teams.append(newTeam)
        }
    
        self.teamsMenuView.deleteTeam = {
            [weak self] number, nameToDelete in
            guard let self = self else { return }
            
            if self.teams.count != self.minNumberOfTeams {
                self.teams.remove(at: number!)
                self.teamsCreator.eraseDeletedName(oldName: nameToDelete!)
            }
            self.musicManager.playSound(soundName: "Transition")
            
        }
        
        self.teamsMenuView.renameTeam = {
            [weak self] num, oldN, newN in
            guard let self = self else { return }

            self.teams[num!] = self.teamsCreator.makeNewTeamName(oldName: oldN!, newName: newN!)
        }
        
        teamsMenuView.nextVC = {
            [weak self] in
            guard let self = self else { return }
            
            let vc = GameKitViewController()
            vc.teams = self.teams
            self.navigationController?.pushViewController(vc, animated: true)

            self.musicManager.playSound(soundName: "Transition")
        }
        
    }
}

//MARK: - PresentAlertDelegate
//Пуш алерта
extension TeamsMenuViewController: PresentAlertDelegate {
    func presentAlert() {
        self.alertManager.showAlertChangeTeamName(title: "Как назовем команду?", target: self)
    }
}

//MARK: - NewNameDelegate
//Замена ячейки по индексу - переименование команды // Удалить?
/*extension TeamsMenuViewController: NewNameDelegate {
    func renameTeam(name: String) {
        guard let index = self.teamsMenuView.sectionToRename else {return}
        self.teams.remove(at: index)
        self.teams.insert(self.teamsCreator.makeNewTeamName(name: name), at: index)
    }
}
*/

//MARK: - PopOver

extension TeamsMenuViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        .none
    }
}
