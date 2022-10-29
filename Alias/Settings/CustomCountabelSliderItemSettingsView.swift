import UIKit

class CustomCountabelSliderItemSettingsView: UIView {
    
    private let sliderResults: [String] = ["выкл.", "редко", "часто", "всегда"]
    private let settingName: String
    private let discribeSetting: String
    
    private lazy var customLabelsStackView: CustomLabelsStackView = {
        let view = CustomLabelsStackView(settingName: self.settingName,
                                         discribeSetting: self.discribeSetting)
        
        return view
    }()
    
    private lazy var emojiLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "🙁"
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 32.0)
        lbl.textColor = .white
        
        return lbl
    }()
    
    private lazy var elementsStack: UIStackView = {
        let sv = UIStackView(arrangedSubviews:
                                [self.customLabelsStackView,
                                 self.emojiLabel
                                ])
        
        sv.alignment = .top
        sv.translatesAutoresizingMaskIntoConstraints = false
        
        return sv
    }()
    
    
    private lazy var customSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 3
        slider.value = 0
        slider.thumbTintColor = UIColor(named: "PersianBlueColor")
        slider.tintColor = .systemGray
        slider.translatesAutoresizingMaskIntoConstraints = false
        
        return slider
    }()
    
    private lazy var sliderResultLabels: [UILabel] = {
        var arr = [UILabel]()
        
        for result in self.sliderResults {
            let lbl = UILabel()
            lbl.font = UIFont(name: "Piazzolla", size: 14.0)
            lbl.text = result
            lbl.textColor = .black
            lbl.textAlignment = .center
            
            arr.append(lbl)
        }
        
        return arr
    }()
    
    private lazy var sliderResultLabelsStack: UIStackView = {
        let sv = UIStackView(arrangedSubviews: self.sliderResultLabels)
        sv.spacing = 32.0
        sv.distribution = .fillEqually
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
        addSubview(self.customSlider)
        addSubview(self.sliderResultLabelsStack)
        
        NSLayoutConstraint.activate([
            
            self.elementsStack.topAnchor.constraint(equalTo: topAnchor),
            self.elementsStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            trailingAnchor.constraint(equalTo: self.elementsStack.trailingAnchor),
            
            self.customSlider.topAnchor.constraint(equalTo: self.elementsStack.bottomAnchor, constant: 16.0),
            self.customSlider.centerXAnchor.constraint(equalTo: centerXAnchor),
            self.customSlider.widthAnchor.constraint(equalTo: self.customLabelsStackView.widthAnchor),
            
            self.sliderResultLabelsStack.topAnchor.constraint(equalTo: self.customSlider.bottomAnchor, constant: 4.0),
            self.sliderResultLabelsStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            trailingAnchor.constraint(equalTo: self.sliderResultLabelsStack.trailingAnchor),
            bottomAnchor.constraint(equalTo: self.sliderResultLabelsStack.bottomAnchor),
        ])
    }
}
