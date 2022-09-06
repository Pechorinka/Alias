//
//  CategoryCell.swift
//  Alias
//
//  Created by Юлия Филимонова on 06.09.2022.
//

import UIKit

class CategoryCell: UITableViewCell {

    override init (style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public lazy var baseView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 25
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 3
        return view
    } ()

    private func setupView () {
        self.addSubview(contentView)
        self.contentView.addSubview(self.baseView)
        contentView.backgroundColor = .white

        NSLayoutConstraint.activate([
            self.contentView.topAnchor.constraint(equalTo: self.topAnchor),
            self.contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),

            self.baseView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            self.baseView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.baseView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            self.baseView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10)

        ])
    }
}
