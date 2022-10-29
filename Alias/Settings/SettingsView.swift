import UIKit

class SettingsView: UIView {
    
    var buttonHandler: (() -> Void)?
    
    private lazy var classicGameView = CustomCountabelBoolItemSettingsView(settingName: "КЛАССИЧЕСКАЯ ИГРА",
                                                                           discribeSetting: "старая добрая классика")
    private lazy var countWordsSetting = CustomCountabelNumericItemSettingsView(settingName: "КОЛИЧЕСТВО СЛОВ",
                                                                                discribeSetting: "для достижения победы",
                                                                                valueSetting: "10",
                                                                                increaseValue: "- 10 СЛОВ",
                                                                                decreaseValue: "+ 10 СЛОВ")
    private lazy var longRoundSetting = CustomCountabelNumericItemSettingsView(settingName: "ДЛИНА РАУНДА",
                                                                               discribeSetting: "на отгадывание слов",
                                                                               valueSetting: "10",
                                                                               increaseValue: "- 10 СЕК",
                                                                               decreaseValue: "+ 10 СЕК")
    private lazy var taskFrequencyInGameSetting = CustomCountabelSliderItemSettingsView(settingName: "ИГРА С ЗАДАНИЯМИ",
                                                                                        discribeSetting: "при объяснении слов")
    private lazy var tasksSelectionSetting = CustomCountableTaskItemSettings(settingName: "СПИСОК ЗАДАНИЙ",
                                                                             discribeSetting: "которые Вам придется выполнять")
    private lazy var lastWordSetting = CustomCountabelBoolItemSettingsView(settingName: "ПОСЛЕДНЕЕ СЛОВО",
                                                                           discribeSetting: "могут отгадывать все команды")
    private lazy var skipFeeSetting = CustomCountabelBoolItemSettingsView(settingName: "ШТРАФ ЗА ПРОПУСК",
                                                                          discribeSetting: "пропущенное слово отнимает одно очко")
    private lazy var nextVCButton = CustomButton(color: .black,
                                                 title: "ДАЛЕЕ",
                                                 titleColor: .white,
                                                 buttonHandler: {
        [weak self] in
        guard let self = self else { return }
        self.buttonHandler?()
    })
    
    
    private lazy var elementsStack: UIStackView = {
        let sv = UIStackView(arrangedSubviews:
                                [
                                    self.classicGameView,
                                    self.countWordsSetting,
                                    self.longRoundSetting,
                                    self.taskFrequencyInGameSetting,
                                    self.tasksSelectionSetting,
                                    self.lastWordSetting,
                                    self.skipFeeSetting
                                ])
        
        sv.axis = .vertical
        sv.spacing = 32.0
        
        return sv
    }()
    
    private lazy var contentStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            self.elementsStack,
            self.nextVCButton
        ])
        sv.axis = .vertical
        sv.spacing = 37.0
        sv.alignment = .fill
        sv.translatesAutoresizingMaskIntoConstraints = false
        
        return sv
    }()
    
    private lazy var containerScrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.showsVerticalScrollIndicator = false
        
        return sv
    }()
    
    private lazy var containerView: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(self.contentStackView)
        
        return container
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.backgroundColor = .white
        
        self.addSubview(self.containerScrollView)
        
        self.containerScrollView.addSubview(self.containerView)
        self.containerView.pin(to: self.containerScrollView)
        
        NSLayoutConstraint.activate([
            
            self.contentStackView.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 22.0),
            self.contentStackView.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 24.0),
            self.contentStackView.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -24.0),
            self.contentStackView.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: -11.0),
            
            self.containerScrollView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            self.containerScrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.containerScrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.containerScrollView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            
            self.containerView.widthAnchor.constraint(equalTo: self.widthAnchor)
            
        ])
    }
}


