
import UIKit

class GameScreenView: UIView {
    var rightButtonTap: (() -> Void)?
    var wrongButtonTap: (() -> Void)?
    var backButtonTap: (() -> Void)?
    
    var remainingSeconds: TimeInterval = 0 {
        didSet {
            self.secondsLabel.text = self.formatter.string(from: .init(value: self.remainingSeconds))
            secondsTextLabel.text = String.fitPluralForm(
                from: ["секунда", "секунды", "секунд"],
                with: Int(self.remainingSeconds)
            )
        }
    }
    
    private var formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale.current
        
        return formatter
    }()
    
    private let round: GameRound
    private let musicManager = MusicModel()
    
    // MARK: - UI elements
    
    private lazy var secondsLabel: UILabel = {
        let label = UILabel()
        label.text = "\(Int(self.round.roundDuration))"
        label.textColor = .black
        label.font = UIFont(name: "Phosphate-Solid", size: 72)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var backButton: MyCustomBackButton = {
        let btn = MyCustomBackButton()
        btn.addTarget(self, action: #selector(backButtonFunc), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        return btn
    }()
    
    private lazy var secondsTextLabel: UILabel = {
        let label = UILabel()
        label.text = "секунд"
        label.textColor = .black
        label.font = UIFont(name: "Phosphate-Solid", size: 24)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Стэк для секунд
    private lazy var secondsStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews:
                                    [
                                        self.secondsLabel,
                                        self.secondsTextLabel
                                    ])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        return stack
    }()
    
    // Лейбл для слова
    private(set) lazy var gameWordLabel: UILabel = {
        let label = UILabel()
        label.text = self.round.currentWord
        label.textColor = .black
        label.font = UIFont(name: "Phosphate-Solid", size: 44)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.minimumScaleFactor = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    // Картинка карточки (игровое поле)
    private lazy var gameImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "imageForWord"))
        image.addSubview(self.gameWordLabel)
        return image
    }()
    
    // Кнопка правильного ответа
    private var rightButton = UIButton()
    
    private lazy var rightAnswerBtn: UIButton = {
        self.rightButton = makeButton(color: "TrefoilCrayolaColor", image: "checkmark")
        self.rightButton.addTarget(self, action: #selector(rightAnswer), for: .touchUpInside)
        return rightButton
    }()
    
    // Кнопка неправильного ответа
    private var wrongButton = UIButton()
    
    private lazy var wrongAnswerBtn: UIButton = {
        self.wrongButton = makeButton(color: "SignalOrangeColor", image: "multiply")
        self.wrongButton.addTarget(self, action: #selector(wrongAnswer), for: .touchUpInside)
        return wrongButton
    }()
    
    // Стэк для кнопок
    private lazy var buttonsStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews:
                                    [
                                        self.wrongAnswerBtn,
                                        self.rightAnswerBtn
                                    ])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 40
        return stack
    }()
    
    // Стэк общий
    private lazy var contentStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews:
                                    [
                                        self.secondsStack,
                                        self.gameImage,
                                        self.buttonsStack
                                    ])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 40
        stack.distribution = .fill
        return stack
    }()
    
    // MARK: - Initialization
    
    init(round: GameRound) {
        self.round = round
        super .init(frame: .zero)
        
        self.setupUI()
        gestureObserver()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func gestureObserver() {
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(elementSwippedLeft(gesture:)))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.addGestureRecognizer(swipeLeft)
        
        let swipeLeft1 = UISwipeGestureRecognizer(target: self, action: #selector(elementSwippedRight(gesture:)))
        swipeLeft1.direction = UISwipeGestureRecognizer.Direction.right
        self.addGestureRecognizer(swipeLeft1)
    }
    
    private func setupUI() {
        
        self.backgroundColor = .white
        addSubview(self.contentStack)
        
        self.addSubview(self.backButton)
        
        NSLayoutConstraint.activate([
            
            self.backButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            self.backButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 24),
            
            self.contentStack.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            self.contentStack.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor),
            
            self.gameWordLabel.centerXAnchor.constraint(equalTo: self.gameImage.centerXAnchor),
            self.gameWordLabel.centerYAnchor.constraint(equalTo: self.gameImage.centerYAnchor),
            
            self.wrongAnswerBtn.widthAnchor.constraint(equalToConstant: 112),
            self.wrongAnswerBtn.heightAnchor.constraint(equalToConstant: 108),
            self.rightAnswerBtn.widthAnchor.constraint(equalToConstant: 112),
            self.rightAnswerBtn.heightAnchor.constraint(equalToConstant: 108)
        ])
    }
    
    private func addTimer(interval: Double){
        Timer.scheduledTimer(timeInterval: interval, target: self,
                             selector: #selector(updateTimer),
                             userInfo: nil, repeats: false)
    }
    
    private func addAnimation(duration: Double, backgroundColor: UIColor) {
        UIView.animate(withDuration: duration, delay: 0.0, options:[.autoreverse], animations: {
            self.backgroundColor = backgroundColor
        }, completion:nil)
    }
    
    // MARK: - Actions
    
    @objc private func rightAnswer(){
        
        gameImage.swipeAnimation(transition: CATransitionSubtype.fromLeft)
        addAnimation(duration: 0.1, backgroundColor: .green)
        addTimer(interval: 0.1)
        self.rightButtonTap?()
    }
    
    @objc private func wrongAnswer(){
        
        gameImage.swipeAnimation(transition: CATransitionSubtype.fromRight)
        addAnimation(duration: 0.1, backgroundColor: .red)
        addTimer(interval: 0.1)
        self.wrongButtonTap?()
    }
    
    @objc private func backButtonFunc() {
        self.backButtonTap?()
    }
    
    @objc func updateTimer(){
        self.backgroundColor = .white
    }
    
    @objc func elementSwippedRight(gesture: UIGestureRecognizer) {
        
        gameImage.swipeAnimation(transition: CATransitionSubtype.fromLeft)
        addAnimation(duration: 0.1, backgroundColor: .green)
        addTimer(interval: 0.1)
        rightButtonTap?()
        
    }
    
    @objc func elementSwippedLeft(gesture: UIGestureRecognizer) {
        
        gameImage.swipeAnimation(transition: CATransitionSubtype.fromRight)
        addAnimation(duration: 0.1, backgroundColor: .red)
        addTimer(interval: 0.1)
        wrongButtonTap?()
    }
}

private extension GameScreenView {
    
    func makeButton(color: String, image: String) -> UIButton {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = UIColor(named: "\(color)")
        btn.layer.cornerRadius = 15
        btn.clipsToBounds = true
        btn.setImage(UIImage(systemName: image), for: .normal)
        return btn
    }
}

    // MARK: - Extension for animation
private extension UIView {
    func swipeAnimation(duration: TimeInterval = 0.5, completionDelegate: AnyObject? = nil, transition: CATransitionSubtype) {

        let leftToRightTransition = CATransition()
        leftToRightTransition.type = CATransitionType.push
        leftToRightTransition.subtype = transition
        leftToRightTransition.duration = duration
        leftToRightTransition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        leftToRightTransition.fillMode = CAMediaTimingFillMode.removed
        
        self.layer.add(leftToRightTransition, forKey: "leftToRightTransition")
    }
}
