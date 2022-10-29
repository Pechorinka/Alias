import UIKit

extension UIButton {
    
    static func makeCountButton(buttonName: String) -> UIButton {
        let btn = UIButton()
        btn.setTitle(buttonName, for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont(name: "Phosphate-Solid", size: 24)
        btn.titleLabel?.textAlignment = .center
        btn.backgroundColor = UIColor(named: "PersianBlueColor")
        btn.layer.cornerRadius = 24.0
        
        return btn
    }
}
