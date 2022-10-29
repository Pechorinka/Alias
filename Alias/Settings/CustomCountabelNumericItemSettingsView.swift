import UIKit

class CustomCountabelNumericItemSettingsView: UIView {
    
    private let settingName: String
    private let discribeSetting: String
    private let valueSetting: String
    private let increaseValue: String
    private let decreaseValue: String
    
    private lazy var customLabelsStackView: CustomLabelsStackView = {
        let view = CustomLabelsStackView(settingName: self.settingName,
                                         discribeSetting: self.discribeSetting)
        
        return view
    }()
    private lazy var valueLabel: UILabel = .makeCountingLabel(value: self.valueSetting)
    private lazy var increaseValueButton: UIButton = {
        let btn = UIButton.makeCountButton(buttonName: self.increaseValue)
        btn.heightAnchor.constraint(equalToConstant: 48.0).isActive = true
        
        return btn
    }()
    private lazy var decreaseValueButton: UIButton = {
        let btn = UIButton.makeCountButton(buttonName: self.decreaseValue)
        btn.heightAnchor.constraint(equalToConstant: 48.0).isActive = true
        
        return btn
    }()
    
    private lazy var labelsStack: UIStackView = {
        let sv = UIStackView(arrangedSubviews:
                                [self.customLabelsStackView,
                                 self.valueLabel
                                ])
        sv.alignment = .top
        sv.translatesAutoresizingMaskIntoConstraints = false
        
        return sv
    }()
    
    private lazy var buttonsStack: UIStackView = {
        let sv = UIStackView(arrangedSubviews:
                                [self.increaseValueButton,
                                 self.decreaseValueButton
                                ])
        sv.spacing = 16.0
        sv.distribution = .fillEqually
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    init(settingName: String,
         discribeSetting: String,
         valueSetting: String,
         increaseValue: String,
         decreaseValue: String)
    {
        self.settingName = settingName
        self.discribeSetting = discribeSetting
        self.valueSetting = valueSetting
        self.increaseValue = increaseValue
        self.decreaseValue = decreaseValue
        super.init(frame: .zero)
        
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        addSubview(self.labelsStack)
        addSubview(self.buttonsStack)
        
        NSLayoutConstraint.activate([
            self.labelsStack.topAnchor.constraint(equalTo: topAnchor),
            self.labelsStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            trailingAnchor.constraint(equalTo: self.labelsStack.trailingAnchor),
//
            self.buttonsStack.topAnchor.constraint(equalTo: self.labelsStack.bottomAnchor, constant: 10.0),
            self.buttonsStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 7.0),
            trailingAnchor.constraint(equalTo: self.buttonsStack.trailingAnchor, constant: 7.0),
            bottomAnchor.constraint(equalTo: self.buttonsStack.bottomAnchor),
        ])
    }
}
