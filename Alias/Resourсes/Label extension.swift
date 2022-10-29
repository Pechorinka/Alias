import UIKit

extension UILabel {
    
    static func makeSettingNameLabel(settingName: String) -> UILabel {
        let lbl = UILabel()
        lbl.text = settingName
        lbl.numberOfLines = 0
        lbl.textAlignment = .left
        lbl.font = UIFont(name: "Phosphate-Solid", size: 24)
        lbl.textColor = .black
        
        return lbl
    }
    
    static func makeDiscribeSettingLabel(discribe: String) -> UILabel {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Piazzolla", size: 16.0)
        lbl.text = discribe
        lbl.textColor = .black
        lbl.numberOfLines = 0
        lbl.textAlignment = .left
        
        return lbl
    }
    
    static func makeCountingLabel(value: String) -> UILabel {
        let lbl = UILabel()
        lbl.text = value
        lbl.textAlignment = .center
        lbl.font = UIFont(name: "Phosphate-Solid", size: 32)
        lbl.textColor = UIColor(named: "PersianBlueColor")
        
        return lbl
    }
}
