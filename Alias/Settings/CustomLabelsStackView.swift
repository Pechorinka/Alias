import UIKit

class CustomLabelsStackView: UIView {
    
    private let settingName: String
    private let discribeSetting: String
    
    private lazy var settingNameLabel: UILabel = .makeSettingNameLabel(settingName: self.settingName)
    private lazy var discribeSettingLabel: UILabel = .makeDiscribeSettingLabel(discribe: self.discribeSetting)
    
    private lazy var settingsNameLabelsStack: UIStackView = {
        let sv = UIStackView(arrangedSubviews:
                                [self.settingNameLabel,
                                 self.discribeSettingLabel
                                ])
        sv.axis = .vertical
        sv.alignment = .leading
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
        
        addSubview(self.settingsNameLabelsStack)
        
        NSLayoutConstraint.activate([
            self.settingsNameLabelsStack.topAnchor.constraint(equalTo: topAnchor),
            bottomAnchor.constraint(equalTo: self.settingsNameLabelsStack.bottomAnchor),
            self.settingsNameLabelsStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            trailingAnchor.constraint(equalTo: self.settingsNameLabelsStack.trailingAnchor),
            
        ])
    }
    
}
