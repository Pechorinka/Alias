
import UIKit

final class GameScreenView: UIView {
    
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
    private var panGesture = UIPanGestureRecognizer()
    
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
        label.sizeToFit()
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private lazy var backCardView: UIView = {
        let backView = UIView()
        backView.translatesAutoresizingMaskIntoConstraints = false
        backView.layer.cornerRadius = 25
        backView.layer.borderColor = UIColor.black.cgColor
        backView.layer.borderWidth = 3
        backView.backgroundColor = .lightGray
        backView.layer.shadowColor = UIColor.black.cgColor
        backView.layer.shadowOpacity = 0.5
        backView.layer.shadowOffset = .zero
        backView.layer.shadowRadius = 3
        return backView
    }()
    
    // Картинка карточки (игровое поле)
    
    private lazy var gameCardView: UIView = {
        let cardView = UIView()
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.layer.cornerRadius = 25
        cardView.layer.borderColor = UIColor.black.cgColor
        cardView.layer.borderWidth = 3
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 0.5
        cardView.layer.shadowOffset = .zero
        cardView.layer.shadowRadius = 3
 
        return cardView
    }()
    
    // Кнопка правильного ответа
    private var rightButton = UIButton()
    
    private lazy var rightAnswerBtn: UIButton = {
        self.rightButton = makeButton(color: "TrefoilCrayolaColor", image: "checkmark")
        self.rightButton.addTarget(self, action: #selector(rightAnswer), for: .touchUpInside)
        self.rightButton.startAnimatingPressActions()
        return rightButton
    }()
    
    // Кнопка неправильного ответа
    private var wrongButton = UIButton()
    
    private lazy var wrongAnswerBtn: UIButton = {
        self.wrongButton = makeButton(color: "SignalOrangeColor", image: "multiply")
        self.wrongButton.addTarget(self, action: #selector(wrongAnswer), for: .touchUpInside)
        self.wrongButton.startAnimatingPressActions()
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
    
    // MARK: - Initialization
    
    init(round: GameRound) {
        self.round = round
        super .init(frame: .zero)
        
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods

    private func setupUI() {
        
        self.backgroundColor = .white
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(panCard))
        
        gameCardView.addGestureRecognizer(panGesture)
        gameCardView.backgroundColor = .white
    }
    
    private func setupConstraints() {
//        backCardView.addSubview(gameImage)
        addSubview(backButton)
        addSubview(secondsStack)
        addSubview(backCardView)
        addSubview(gameCardView)
        gameCardView.addSubview(self.gameWordLabel)
        addSubview(buttonsStack)
        
        NSLayoutConstraint.activate([
            
            self.backButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            self.backButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 24),
            
            self.secondsStack.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            self.secondsStack.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            
            self.gameCardView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 2/3),
            self.gameCardView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5),
            self.gameCardView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.gameCardView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            self.backCardView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 2/3),
            self.backCardView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5),
            self.backCardView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.backCardView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            self.gameWordLabel.centerXAnchor.constraint(equalTo: self.gameCardView.centerXAnchor),
            self.gameWordLabel.centerYAnchor.constraint(equalTo: self.gameCardView.centerYAnchor),
            self.gameWordLabel.widthAnchor.constraint(equalTo: self.gameCardView.widthAnchor, constant: -24),
            
            self.buttonsStack.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            self.buttonsStack.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            self.wrongAnswerBtn.widthAnchor.constraint(equalToConstant: 112),
            self.wrongAnswerBtn.heightAnchor.constraint(equalToConstant: 108),
            self.rightAnswerBtn.widthAnchor.constraint(equalToConstant: 112),
            self.rightAnswerBtn.heightAnchor.constraint(equalToConstant: 108)
        ])
    }
    
    // Анимация бэкграунда если пользуемся кнопками
    private func addBackgroundAnimation(duration: Double, backgroundColor: UIColor) {
        UIView.animate(withDuration: duration, delay: 0.0, animations: {
            self.backgroundColor = backgroundColor
        }, completion: { _ in
            self.backgroundColor = .white
        })
    }
    
    // MARK: - Actions
    
    @objc func panCard(_ sender: UIPanGestureRecognizer) {
      guard let card = sender.view else { return }
      let point = sender.translation(in: self)
      card.center = CGPoint(x: self.center.x + point.x, y: self.center.y + point.y)
      let xFromCenter = card.center.x - self.center.x
      let absXFromCenter = abs(xFromCenter)
      let isRight = xFromCenter > 0
      var scale: CGFloat = 1.0
      if absXFromCenter > 100 {
        scale = 100 / absXFromCenter
      }
//      backCardView.alpha = absXFromCenter / self.center.x /
        self.gameCardView.backgroundColor = isRight ? .green : .red
      
      card.transform = CGAffineTransform(rotationAngle: xFromCenter / (self.frame.height - card.center.y)).scaledBy(x: scale, y: scale)
      if sender.state == UIGestureRecognizer.State.ended {
        
        if card.center.x < 75 {
          UIView.animate(withDuration: 0.2, animations: {
            card.center = CGPoint(x: card.center.x - 200, y: card.center.y + 75)
            card.alpha = 0
          }) { _ in
            self.resetCard()
              DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
              card.alpha = 1
                self.wrongButtonTap?()
            }
          }
        } else if card.center.x > (self.frame.width - 75) {
          
          UIView.animate(withDuration: 0.2, animations: {
            card.center = CGPoint(x: card.center.x + 200, y: card.center.y + 75)
            card.alpha = 0
          }) { _ in
            self.resetCard()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
              card.alpha = 1
                self.rightButtonTap?()
            }
          }
        } else {
          resetCard()
        }
      }
    }
    
    func resetCard() {
      UIView.animate(withDuration: 0.2) {
        self.gameCardView.center = self.center
          self.gameCardView.backgroundColor = .white
        self.gameCardView.transform = .identity
      }
    }
    
    @objc private func rightAnswer(){
        gameCardView.swipeAnimation(transition: CATransitionSubtype.fromLeft)
        addBackgroundAnimation(duration: 0.3, backgroundColor: .green)
        self.rightButtonTap?()
    }
    
    @objc private func wrongAnswer(){
        
        gameCardView.swipeAnimation(transition: CATransitionSubtype.fromRight)
        addBackgroundAnimation(duration: 0.1, backgroundColor: .red)
        self.wrongButtonTap?()
    }
    
    @objc private func backButtonFunc() {
        self.backButtonTap?()
    }
    
    @objc private func elementSwippedRight(gesture: UIGestureRecognizer) {
        
        gameCardView.swipeAnimation(transition: CATransitionSubtype.fromLeft)
        addBackgroundAnimation(duration: 0.1, backgroundColor: .green)
        rightButtonTap?()
        
    }
    
    @objc private func elementSwippedLeft(gesture: UIGestureRecognizer) {
        
        gameCardView.swipeAnimation(transition: CATransitionSubtype.fromRight)
        addBackgroundAnimation(duration: 0.1, backgroundColor: .red)
        wrongButtonTap?()
    }
}

// MARK: - Extensions

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

private extension UIView {
    func swipeAnimation(duration: TimeInterval = 0.3, transition: CATransitionSubtype) {
        
        let swipeTransition = CATransition()
        swipeTransition.type = CATransitionType.push
        swipeTransition.subtype = transition
        swipeTransition.duration = duration
        swipeTransition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        swipeTransition.fillMode = CAMediaTimingFillMode.removed
        
        self.layer.add(swipeTransition, forKey: "leftToRightTransition")
    }
}
