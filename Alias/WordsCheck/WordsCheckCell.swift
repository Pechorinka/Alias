//
//  WordsCheckCell.swift
//  Alias
//
//  Created by Юлия Филимонова on 09.10.2022.
//

import UIKit

class WordsCheckCell: UITableViewCell {

    override init (style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = .white

        self.setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var baseView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.backgroundColor = UIColor(named: "RoyalBlueColor")
        view.layer.cornerRadius = 16
        return view
    } ()

    private lazy var wordLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.text = "слово"
        label.textColor = .white
        label.font = UIFont(name: "Phosphate-Solid", size: 20)
        return label
    }()

    private lazy var checkSwitcher: UISwitch = {
        let switcher = UISwitch()
        switcher.isOn = true
        switcher.onTintColor = UIColor(named: "PersianBlueColor")
        switcher.layer.borderWidth = 1
        switcher.layer.cornerRadius = 14
        switcher.setOn(true, animated: true)
        switcher.addTarget(self, action: #selector(changeValue), for: .allTouchEvents)
        return switcher
    }()

    @objc private func changeValue() {
        print("Изменить решение!")
    }

    private lazy var cellStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews:
                                [
                                    self.wordLabel,
                                    self.checkSwitcher

                                ])
        stackView.axis = .horizontal
        stackView.spacing = 0
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    

    private func setupView() {
        self.addSubview(contentView)
        [
            self.baseView,
            self.cellStackView
        ].forEach { self.contentView.addSubview($0) }

        NSLayoutConstraint.activate([
        self.contentView.topAnchor.constraint(equalTo: self.topAnchor),
        self.contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
        self.contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        self.contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),

        self.baseView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5),
        self.baseView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
        self.baseView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10),
        self.baseView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5),

        self.cellStackView.topAnchor.constraint(equalTo: self.baseView.topAnchor, constant: 5),
        self.cellStackView.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 10),
        self.cellStackView.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor, constant: -10),
        self.cellStackView.bottomAnchor.constraint(equalTo: self.baseView.bottomAnchor, constant: -5),
        ])

    }

}
