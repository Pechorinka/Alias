import UIKit

class CustomCountabelBoolItemSettingsView: UIView {
    
    private let settingName: String
    private let discribeSetting: String
    
    private lazy var customLabelsStackView: CustomLabelsStackView = {
        let view = CustomLabelsStackView(settingName: self.settingName,
                                         discribeSetting: self.discribeSetting)
        
        return view
    }()
    
    private lazy var customSwitcher: UISwitch = .makeCustomSwitcher()
    
    private lazy var elementsStack: UIStackView = {
        let sv = UIStackView(arrangedSubviews:
                                [self.customLabelsStackView,
                                 self.customSwitcher
                                ])
        
        sv.alignment = .top
        sv.translatesAutoresizingMaskIntoConstraints = false
        
        return sv
    }()
    
    init(settingName: String,
         discribeSetting: String)
    {
        self.settingName = settingName
        self.discribeSetting = discribeSetting
        super.init(frame: .zero)
        
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        addSubview(self.elementsStack)
        
        NSLayoutConstraint.activate([
            self.elementsStack.topAnchor.constraint(equalTo: topAnchor),
            self.elementsStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            trailingAnchor.constraint(equalTo: self.elementsStack.trailingAnchor),
            bottomAnchor.constraint(equalTo: self.elementsStack.bottomAnchor),
        ])
    }
}
