import UIKit

class CustomCountableTaskItemSettings: UIView {
    
    private let settingName: String
    private let discribeSetting: String
    
    private lazy var customLabelsStackView: CustomLabelsStackView = {
        let view = CustomLabelsStackView(settingName: self.settingName,
                                         discribeSetting: self.discribeSetting)
        
        return view
    }()
    
    private lazy var customButton: UIButton = {
        let btn = UIButton()
        let configuration = UIImage.SymbolConfiguration(pointSize: 20)
        let image = UIImage(systemName: "chevron.right", withConfiguration: configuration)
        btn.setImage(image, for: .normal)
        btn.tintColor = .black
        btn.backgroundColor = .white
        btn.addTarget(self, action: #selector(self.tapOnButton), for: .touchUpInside)
        
        return btn
    }()
    
    private lazy var elementsStack: UIStackView = {
        let sv = UIStackView(arrangedSubviews:
                                [self.customLabelsStackView,
                                 self.customButton
                                ])
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
            bottomAnchor.constraint(equalTo: self.elementsStack.bottomAnchor),
            self.elementsStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            trailingAnchor.constraint(equalTo: self.elementsStack.trailingAnchor),
        ])
    }
    
    @objc private func tapOnButton() {
        print("I tap on this button")
    }

}
