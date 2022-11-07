
import UIKit
import SwiftConfettiView

//Протокол для пуша алертов
protocol PresentAlertDelegate: AnyObject {
    func presentAlert()
}

class ResultScreenView: UIView {
    
    weak var delegate: PresentAlertDelegate?
    var backStartVC: (() -> Void)?
    var finalists: [Team]
    private let winner: Team
    
    //MARK: - create UI elements
    
    private lazy var confettiView = SwiftConfettiView(frame: UIScreen.main.bounds)
    
    private let backgroundImage: UIImageView = {
        let backgroundImage = UIImageView()
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.image = UIImage(named: "Ellipse Background")
        return backgroundImage
    }()
    
    private lazy var teamLabel: UILabel = {
        let teamLabel = UILabel()
        teamLabel.translatesAutoresizingMaskIntoConstraints = false
        teamLabel.textAlignment = .center
        teamLabel.textColor = .white
        teamLabel.font = UIFont(name: "Phosphate-Solid", size: 40)
        return teamLabel
    }()
    
    private lazy var winLabel: UILabel = {
        let winLabel = UILabel()
        winLabel.translatesAutoresizingMaskIntoConstraints = false
        winLabel.text = "WIN!"
        winLabel.textAlignment = .center
        winLabel.textColor = UIColor(named: "YellowColor")
        winLabel.font = UIFont(name: "Phosphate-Solid", size: 40)
        return winLabel
    }()
    
    private lazy var circleLabel: UILabelWithInsets = {
        let circleLabel = UILabelWithInsets()
        circleLabel.textInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        circleLabel.translatesAutoresizingMaskIntoConstraints = false
        circleLabel.backgroundColor = .white
        circleLabel.textAlignment = .center
        circleLabel.textColor = .black
        circleLabel.sizeToFit()
        circleLabel.adjustsFontSizeToFitWidth = true
        circleLabel.layer.masksToBounds = true
        circleLabel.layer.cornerRadius = 35
        circleLabel.font = UIFont(name: "Phosphate-Solid", size: 40)
        return circleLabel
    }()
    
    private lazy var cupImage: UIImageView = {
        let cupImage = UIImageView()
        cupImage.translatesAutoresizingMaskIntoConstraints = false
        cupImage.image = UIImage(named: "Goodies Appreciation(pdf)")
        return cupImage
    }()
    
    private lazy var winStackView: UIStackView = {
        let winStackView = UIStackView(arrangedSubviews:
                                        [
                                            self.teamLabel,
                                            self.winLabel,
                                        ])
        winStackView.axis = .vertical
        winStackView.spacing = 0.0
        winStackView.alignment = .center
        winStackView.translatesAutoresizingMaskIntoConstraints = false
        return winStackView
    }()
    
    private lazy var cupStackView: UIStackView = {
        let winStackView = UIStackView(arrangedSubviews:
                                        [
                                            self.circleLabel,
                                            self.cupImage
                                        ])
        winStackView.axis = .horizontal
        winStackView.spacing = 20.0
        winStackView.alignment = .center
        winStackView.translatesAutoresizingMaskIntoConstraints = false
        return winStackView
    }()
    
    
    private lazy var resultTableView: UITableView = {
        let resultTableView = UITableView(frame: self.bounds, style: .plain)
        resultTableView.dataSource = self
        resultTableView.translatesAutoresizingMaskIntoConstraints = false
        resultTableView.register(ScoreCell.self, forCellReuseIdentifier: "ScoreCell")
        resultTableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        resultTableView.delegate = self
        resultTableView.separatorStyle = .none
        resultTableView.backgroundColor = .white
        return resultTableView
    } ()
    
    private lazy var bottomButton: CustomButton = {
        let bottomButton = CustomButton(color: .black, title: "Новая игра", titleColor: .white, buttonHandler: {
            [weak self] in
            guard let self = self else { return }
            self.backStartVC?()
        })
        return bottomButton
    }()
    
    //MARK: - Initialization
    
    init(finalists: [Team]) {
        self.winner = finalists.first!
        self.finalists = Array(finalists.dropFirst())
        super.init(frame: .zero)
        
        setupUI()
        setupConstraints()
        confettiView.startConfetti()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private methods
    
    private func setupUI() {
        
        backgroundColor = .white
        confettiView.intensity = 0.7
        confettiView.type = .confetti
        teamLabel.text = self.winner.name
        circleLabel.text = String(self.winner.scores)
    }
    
    private func setupConstraints() {
        
        [self.backgroundImage,
         self.winStackView,
         self.cupImage,
         self.circleLabel,
         self.resultTableView,
         self.bottomButton].forEach { self.addSubview($0)}
        self.addSubview(confettiView)
        
        NSLayoutConstraint.activate([
            self.backgroundImage.topAnchor.constraint(equalTo: self.topAnchor),
            self.backgroundImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.backgroundImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.backgroundImage.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.6),
            
            self.winStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.winStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor,
                                                   constant: 30),
            
            self.cupImage.topAnchor.constraint(equalTo: self.winStackView.bottomAnchor),
            self.cupImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.cupImage.heightAnchor.constraint(equalToConstant: 255),
            self.cupImage.widthAnchor.constraint(equalToConstant: 185),
            
            self.circleLabel.topAnchor.constraint(equalTo: self.cupImage.topAnchor, constant: 100),
            self.circleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.circleLabel.heightAnchor.constraint(equalToConstant: 70),
            self.circleLabel.widthAnchor.constraint(equalToConstant: 70),
            
            self.resultTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.resultTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.resultTableView.topAnchor.constraint(equalTo: self.backgroundImage.bottomAnchor, constant: 2),
            self.resultTableView.bottomAnchor.constraint(equalTo: self.bottomButton.topAnchor, constant: -10),
            
            self.bottomButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            self.bottomButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            self.bottomButton.heightAnchor.constraint(equalToConstant: 66),
            self.bottomButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -11)
        ])
    }
    
}

// MARK: - Extensions

//MARK: - UITableViewDataSource

extension ResultScreenView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return finalists.count
    }
    
    private func sectionColor(section: Int)-> UIColor {
        var color: UIColor = .gray
        if section == 0 {
            color = UIColor(named: "RoyalBlueColor") ?? .gray
        } else if section == 1 {
            color = UIColor(named: "DarkPurpleColor") ?? .gray
        } else if section == 2 {
            color =  UIColor(named: "OrangeColor") ?? .gray
        }
        return color
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScoreCell", for: indexPath) as? ScoreCell
        if let cell = cell {
            
            // TO DO обработать колличество ячеек
            let countOfSection = indexPath.section % 3
            cell.myView.backgroundColor = sectionColor(section: countOfSection)
            
            let finalists = finalists[indexPath.section]
            cell.teamLabel.text = finalists.name
            cell.scoreLabel.text = String(finalists.scores)
            
            return cell
        }
        return UITableViewCell()
    }
}

//MARK: - UITableViewDelegate

extension ResultScreenView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 82
    }
    
    internal func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
}
