
import UIKit

protocol TapButtonDelegate: AnyObject {
    func didBackChoice()
    func didForwardChoice()
    func didMakeChoice()
}

final class GameKitView: UIView {
    
    weak var delegate: TapButtonDelegate?

    private lazy var backButton: UIButton = {
        let backButton = UIButton()
        backButton.translatesAutoresizingMaskIntoConstraints = false
        let configuration = UIImage.SymbolConfiguration(pointSize: 25)
        let image = UIImage(systemName: "chevron.left", withConfiguration: configuration)
        backButton.setImage(image, for: .normal)
        backButton.tintColor = .black
        backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        backButton.startAnimatingPressActions()
        return backButton
    }()

    @objc private func didTapBackButton() {
        self.delegate?.didBackChoice()
    }

    lazy var choiceImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.shadowColor = UIColor(named: "RoyalBlueColor")?.cgColor
        imageView.layer.shadowOpacity = 0.5
        imageView.layer.shadowOffset = .zero
        imageView.layer.shadowRadius = 3
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        let swipeImageRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeImageRight))
        let swipeImageLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeImageLeft))
        swipeImageRight.direction = .right
        swipeImageLeft.direction = .left
        imageView.addGestureRecognizer(swipeImageRight)
        imageView.addGestureRecognizer(swipeImageLeft)
        return imageView
    }()

    @objc private func swipeImageRight() {
        self.delegate?.didForwardChoice()
    }

    @objc private func swipeImageLeft() {
        self.delegate?.didBackChoice()
    }

     private lazy var forwardButton: UIButton = {
        let forwardButton = UIButton()
        forwardButton.translatesAutoresizingMaskIntoConstraints = false
        let configuration = UIImage.SymbolConfiguration(pointSize: 25)
        let image = UIImage(systemName: "chevron.right", withConfiguration: configuration)
        forwardButton.setImage(image, for: .normal)
        forwardButton.tintColor = .black
        forwardButton.addTarget(self, action: #selector(didTapForwardButton), for: .touchUpInside)
        forwardButton.startAnimatingPressActions()
        return forwardButton
    }()

    @objc private func didTapForwardButton() {
        self.delegate?.didForwardChoice()
    }

    private lazy var imageStackView: UIStackView = {
        let imageStackView = UIStackView(arrangedSubviews:
                                [
                                    self.backButton,
                                    self.choiceImageView,
                                    self.forwardButton
                                ])
        imageStackView.axis = .horizontal
        imageStackView.spacing = 8.0
        imageStackView.alignment = .center
        imageStackView.translatesAutoresizingMaskIntoConstraints = false
        return imageStackView
    }()

    var levelLabel: UILabel = {
        let levelLabel = UILabel()
        levelLabel.translatesAutoresizingMaskIntoConstraints = false
        levelLabel.backgroundColor = .white
        levelLabel.numberOfLines = 0
        levelLabel.lineBreakMode = .byWordWrapping
        levelLabel.textAlignment = .center
        levelLabel.font = UIFont(name: "Phosphate-Solid", size: 28)
        return levelLabel
    }()

    var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.backgroundColor = .white
        descriptionLabel.textColor = .black
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.textAlignment = .center
        descriptionLabel.font = UIFont(name: "Piazzolla", size: 20)
        return descriptionLabel
    }()

    var exampleLabel: UILabel = {
        let exampleLabel = UILabel()
        exampleLabel.translatesAutoresizingMaskIntoConstraints = false
        exampleLabel.backgroundColor = .white
        exampleLabel.textColor = .black
        exampleLabel.numberOfLines = 0
        exampleLabel.lineBreakMode = .byWordWrapping
        exampleLabel.textAlignment = .center
        exampleLabel.font = UIFont(name: "Piazzolla", size: 20)
        return exampleLabel
    }()

    private lazy var labelStackView: UIStackView = {
        let labelStackView = UIStackView(arrangedSubviews:
                                [
                                    self.levelLabel,
                                    self.descriptionLabel,
//                                    self.exampleLabel
                                ])
        labelStackView.axis = .vertical
        labelStackView.spacing = 20.0
        labelStackView.alignment = .center
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        return labelStackView
    }()

     private lazy var bottomButton: CustomButton = {
         let bottomButton = CustomButton(color: .black, title: "Далее", titleColor: .white, buttonHandler: {
             [weak self] in
             guard let self = self else { return }
             self.delegate?.didMakeChoice()
         })
        return bottomButton
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.setViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setViews() {[
        self.imageStackView,
        self.labelStackView,
        self.bottomButton
    ].forEach { self.addSubview($0) }

        NSLayoutConstraint.activate([
            self.imageStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            self.imageStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),

            self.choiceImageView.heightAnchor.constraint(equalToConstant: 300),
            self.choiceImageView.widthAnchor.constraint(equalToConstant: 300),

            self.labelStackView.topAnchor.constraint(equalTo: imageStackView.bottomAnchor),
            self.labelStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            self.labelStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),

            self.bottomButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -11),
            self.bottomButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            self.bottomButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            self.bottomButton.heightAnchor.constraint(equalToConstant: 66)
        ])
    }
    
}
