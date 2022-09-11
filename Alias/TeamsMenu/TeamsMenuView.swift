
import UIKit

class TeamsMenuView: UIView {

    weak var delegate: PresentAlertDelegate? //Протокол для пуша алерта (ищи в файле ResultScreenView). Может вынесем протоколы в отдельный фаил?
    
    let minNumberOfTeams: Int
    let maxNumberOfTeams: Int

    // Переменная куда приходит номер выбранной ячекий
    var sectionToRename: Int?

    var teams: [Team] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    var addNewTeam :(() -> Void)?
    var deleteTeam :((Int?, String?) -> Void)?
    var nextVC :(() -> Void)?
    var renameTeam :((Int?, String?, String?) -> Void)?
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: self.bounds, style: .plain)
         tableView.dataSource = self
         tableView.backgroundColor = .white
         tableView.translatesAutoresizingMaskIntoConstraints = false
         tableView.register(TeamCell.self, forCellReuseIdentifier: "TeamCell")
        tableView.register(PlusCell.self, forCellReuseIdentifier: "PlusCell")
         tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
         tableView.delegate = self
         tableView.separatorStyle = .none
         return tableView
     } ()
    

    private lazy var nextButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .black
        btn.setTitle("Далее", for: .normal)
        btn.titleLabel?.font = UIFont(name: "Phosphate-Solid", size: 24)
        btn.titleLabel?.textColor = .white
        btn.layer.cornerRadius = 16
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        btn.startAnimatingPressActions()
        return btn
    }()
    
    init(minNumberOfTeams: Int, maxNumberOfTeams: Int, teams: [Team], frame: CGRect = .zero) {
        self.minNumberOfTeams = minNumberOfTeams
        self.maxNumberOfTeams = maxNumberOfTeams
        self.teams = teams
        
        super.init(frame: frame)
        
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        self.overrideUserInterfaceStyle = .light
        addSubview(self.tableView)
        
        addSubview(self.nextButton)
        
        NSLayoutConstraint.activate([
            
            self.nextButton.heightAnchor.constraint(equalToConstant: 66),
            self.nextButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -11),
            self.nextButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            self.nextButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            
            self.tableView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            self.tableView.bottomAnchor.constraint(equalTo: self.nextButton.topAnchor, constant: -16),
            self.tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
    
    @objc func didTapPlusButton(sender: UIButton) {
        self.addNewTeam?()
        self.tableView.reloadData()
    }
    
    @objc func didTapNextButton() {
        self.nextVC?()
    }
    
}

extension TeamsMenuView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section < teams.count {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TeamCell", for: indexPath) as! TeamCell
        
            let team = self.teams[indexPath.section]
            cell.teamLabel.text = team.name
            cell.teamLabel.textColor = .white
            cell.crossDelete = {
                [weak self] in
                guard let self = self else { return }
                
                self.deleteTeam?(indexPath.section, team.name)
            }
            
            cell.donePress = {
                [weak self] in
                guard let self = self else { return }
                
                print (team.name)
                self.renameTeam!(indexPath.section, team.name, cell.teamLabel.text)
                self.tableView.reloadData()
            }
            
            cell.cancelPress = {
                [weak self] in
                guard let self = self else { return }
                
                self.tableView.reloadData()
            }
            
            if teams.count == 2 {
                cell.crossImage.isHidden = true
            } else {
                cell.crossImage.isHidden = false
            }
            
            let rest = indexPath.section % 3
            
            if rest == 0 {
                cell.myView.backgroundColor = UIColor(named: "RoyalBlueColor")
            } else if rest == 1 {
                cell.myView.backgroundColor = UIColor(named: "DarkPurpleColor")
            } else if rest == 2 {
                cell.myView.backgroundColor = UIColor(named: "OrangeColor")
            }
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PlusCell", for: indexPath) as! PlusCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66+16
    }
    
    internal func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10 // это расстояние, а не кол-во команд
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if teams.count == maxNumberOfTeams {
            return self.teams.count
        }
        else {
            return self.teams.count + 1
        }
    }

//Передает пуш делегату в TeamMenuViewController
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == teams.count {
            self.addNewTeam?()
            self.tableView.reloadData()
            tableView.scrollToRow(at: indexPath, at: .top, animated: true)
        } else {
            self.sectionToRename = indexPath.section
            let cell = self.tableView.cellForRow(at: indexPath) as! TeamCell
            cell.teamLabel.becomeFirstResponder()
        }
    }
    
}

