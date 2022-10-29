import UIKit

extension UISwitch {
    
    static func makeCustomSwitcher() -> UISwitch {
        let switcher = UISwitch()
        switcher.onTintColor = UIColor(named: "PersianBlueColor")
        switcher.thumbTintColor = .white
        switcher.tintColor = .lightGray
        
        return switcher
    }
}
