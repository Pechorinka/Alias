
import UIKit

class RulesView: UIView {
    
    private let imageName: String
    private let descriptionRuleText: String
    private let ruleText: String
    private let shouldBottomButtonVisible: Bool
    private var navBarBackButtonHandler: (() -> Void)?
    private var bottomBackButtonHandler: (() -> Void)?
    
    private lazy var backButton: MyCustomBackButton = {
        let btn = MyCustomBackButton()
        btn.addTarget(self, action: #selector(tapNavBarBackButton), for: .touchUpInside)

        return btn
    }()
    
    private lazy var ruleLabel: UILabel = {
        let label = UILabel()
        label.text = "ПРАВИЛА"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: "Phosphate-Solid", size: 30.0)
        
        return label
    }()
    
    private lazy var capView: UIView = {
        let view = UIView()
        
        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(equalToConstant: 40)
        ])
    
        return view
    }()
    
    private lazy var customNavigationBarStack: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            self.backButton,
            self.ruleLabel,
            self.capView
        ])
        sv.axis = .horizontal
        sv.distribution = .equalCentering
        sv.translatesAutoresizingMaskIntoConstraints = false
        
        return sv
    }()
    
    private lazy var centralImageView: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.image = UIImage(named: self.imageName)
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.shadowColor = UIColor(named: "RoyalBlueColor")?.cgColor
        iv.layer.shadowOpacity = 0.5
        iv.layer.shadowOffset = .zero
        iv.layer.shadowRadius = 3
        
        return iv
    }()
    
    private lazy var descriptionRuleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Phosphate-Solid", size: 26)
        label.textColor = UIColor(named: "RoyalBlueColor")
        label.text = self.descriptionRuleText
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    private lazy var ruleTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Piazzolla", size: 20.0)
        label.text = self.ruleText
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var startMenuVCButton: CustomButton = {
        let btn = CustomButton(color: .black,
                               title: "К ИГРЕ",
                               titleColor: .white,
                               buttonHandler: {
            [weak self] in
            guard let self = self else { return }
            self.bottomBackButtonHandler?()
        })
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        return btn
    }()
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15.0
        view.backgroundColor = .white
        view.layer.borderWidth = 7.0
        view.layer.borderColor = UIColor(named: "ShadowColor")?.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()

    init(imageName: String,
         descriptionRuleText: String,
         ruleText: String,
         navBarBackButtonHandler: (() -> Void)?,
         bottomBackButtonHandler: (() -> Void)?,
         shouldBottomButtonVisible: Bool = false
    ) {
        self.imageName = imageName
        self.descriptionRuleText = descriptionRuleText
        self.ruleText = ruleText
        self.navBarBackButtonHandler = navBarBackButtonHandler
        self.bottomBackButtonHandler = bottomBackButtonHandler
        self.shouldBottomButtonVisible = shouldBottomButtonVisible
        super.init(frame: .zero)
        
        let shouldNavBarHidden = Core.shared.isFirstAppStartup
        
        if shouldNavBarHidden {
            self.customNavigationBarStack.isHidden = true
            self.customNavigationBarStack.heightAnchor.constraint(equalToConstant: 0.0).isActive = true
        }
        
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.backgroundColor = UIColor(named: "RoyalBlueColorBlack")
        
        self.addSubview(self.backgroundView)
        self.backgroundView.addSubview(self.customNavigationBarStack)
        self.backgroundView.addSubview(self.centralImageView)
        self.backgroundView.addSubview(self.descriptionRuleLabel)
        self.backgroundView.addSubview(self.ruleTextLabel)
        
        self.backButton.setContentCompressionResistancePriority(.required, for: .vertical)
        self.descriptionRuleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        self.centralImageView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)

        NSLayoutConstraint.activate([
            self.backgroundView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10.0),
            self.backgroundView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10.0),
            self.backgroundView.topAnchor.constraint(equalTo: self.topAnchor, constant: 80.0),
            self.backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -80.0),
            
            self.customNavigationBarStack.centerXAnchor.constraint(equalTo: self.backgroundView.centerXAnchor),
            self.customNavigationBarStack.widthAnchor.constraint(equalTo: self.backgroundView.widthAnchor, constant: -40.0),
            self.customNavigationBarStack.topAnchor.constraint(equalTo: self.backgroundView.topAnchor, constant: 20.0),
            
            self.centralImageView.centerXAnchor.constraint(equalTo: self.backgroundView.centerXAnchor),
            self.centralImageView.widthAnchor.constraint(equalTo: self.backgroundView.widthAnchor, constant: -40.0),
            self.centralImageView.topAnchor.constraint(equalTo: self.customNavigationBarStack.bottomAnchor, constant: 40.0),

            self.descriptionRuleLabel.centerXAnchor.constraint(equalTo: self.backgroundView.centerXAnchor),
            self.descriptionRuleLabel.widthAnchor.constraint(equalTo: self.backgroundView.widthAnchor, constant: -40.0),
            self.descriptionRuleLabel.topAnchor.constraint(equalTo: self.centralImageView.bottomAnchor, constant: 20.0),
            
            self.ruleTextLabel.centerXAnchor.constraint(equalTo: self.backgroundView.centerXAnchor),
            self.ruleTextLabel.widthAnchor.constraint(equalTo: self.backgroundView.widthAnchor, constant: -40.0),
            self.ruleTextLabel.topAnchor.constraint(equalTo: self.descriptionRuleLabel.bottomAnchor, constant: 20.0),
        ])

        
        if self.shouldBottomButtonVisible {
            self.backgroundView.addSubview(self.startMenuVCButton)
            
            NSLayoutConstraint.activate([
                self.startMenuVCButton.centerXAnchor.constraint(equalTo: self.backgroundView.centerXAnchor),
                self.startMenuVCButton.topAnchor.constraint(equalTo: self.ruleTextLabel.bottomAnchor, constant: 10.0),
                self.startMenuVCButton.bottomAnchor.constraint(equalTo: self.backgroundView.bottomAnchor, constant: -20.0)
            ])
        } else {
            self.ruleTextLabel.bottomAnchor.constraint(equalTo: self.backgroundView.bottomAnchor, constant: -20.0).isActive = true
        }
    }
}

//Actions
extension RulesView {
    @objc private func tapNavBarBackButton() {
        self.navBarBackButtonHandler?()
    }
    
    @objc private func goStartMenuButtonTap() {
        self.bottomBackButtonHandler?()
    }
}
