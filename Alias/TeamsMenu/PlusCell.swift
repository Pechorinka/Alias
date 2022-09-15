//
//  PlusCell.swift
//  Alias
//
//  Created by Tatyana Sidoryuk on 07.08.2022.
//

import UIKit

class PlusCell: UITableViewCell {
    
    private lazy var plusButton: UIButton = {
        let homeSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: 40, weight: .black)
        let btn = UIButton()
        let image = UIImage(systemName: "plus.square.fill", withConfiguration: homeSymbolConfiguration)
        btn.setImage(image, for: .normal)
        btn.tintColor = .black
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.isUserInteractionEnabled = true

        return btn
    }()
    
    override init (style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView () {
        self.addSubview(plusButton)
        NSLayoutConstraint.activate([
            self.plusButton.heightAnchor.constraint(equalToConstant: 60),
            self.plusButton.widthAnchor.constraint(equalToConstant: 60),
            self.plusButton.centerXAnchor.constraint(equalTo: self.centerXAnchor)])
    }
}
