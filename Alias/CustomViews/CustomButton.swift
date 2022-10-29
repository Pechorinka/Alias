
import UIKit

class CustomButton: UIView {
    var buttonHandler: (() -> Void)?
    
    private var button = UIButton()

    init(color: UIColor,
         title: String,
         titleColor: UIColor,
         buttonHandler: @escaping () -> Void)
    {
        self.button = UIButton.makeButton(color: color,
                                          title: title,
                                          titleColor: titleColor)
        self.buttonHandler = buttonHandler
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.button.addTarget(self, action: #selector(self.keyPressed), for: .touchUpInside)
        self.setupView()
    }
    
    required init?(coder eCoder: NSCoder) {
        fatalError()
    }
    
    @objc private func keyPressed() {
        self.buttonHandler?()
    }
    
    private func setupView() {
        
        addSubview(button)
        
        NSLayoutConstraint.activate([
            self.button.topAnchor.constraint(equalTo: topAnchor),
            bottomAnchor.constraint(equalTo: self.button.bottomAnchor),
            self.button.leadingAnchor.constraint(equalTo: leadingAnchor),
            trailingAnchor.constraint(equalTo: self.button.trailingAnchor),
            
        ])
    }
}

extension UIButton {
    
    static func makeButton(color: UIColor, title: String, titleColor: UIColor) -> UIButton {
        let btn = UIButton()
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(titleColor, for: .normal)
        btn.backgroundColor = color
        btn.titleLabel?.font = UIFont(name: "Phosphate-Solid", size: 24)
        btn.titleLabel?.textAlignment = .center
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 16
        btn.startAnimatingPressActions()
        
        NSLayoutConstraint.activate([
            btn.widthAnchor.constraint(equalToConstant: 327.0),
            btn.heightAnchor.constraint(equalToConstant: 66.0)
        ])
        
        return btn
    }
    
    // Animation
    
    func startAnimatingPressActions() {
        addTarget(self, action: #selector(animateDown), for: [.touchDown, .touchDragEnter])
        addTarget(self, action: #selector(animateUp), for: [.touchDragExit, .touchCancel, .touchUpInside, .touchUpOutside])
    }
    
    @objc private func animateDown(sender: UIButton) {
        animate(sender, transform: CGAffineTransform.identity.scaledBy(x: 0.95, y: 0.95))
    }
    
    @objc private func animateUp(sender: UIButton) {
        animate(sender, transform: .identity)
    }
    
    private func animate(_ button: UIButton, transform: CGAffineTransform) {
        UIView.animate(withDuration: 0.4,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 3,
                       options: [.curveEaseInOut],
                       animations: {
                        button.transform = transform
            }, completion: nil)
    }
}
