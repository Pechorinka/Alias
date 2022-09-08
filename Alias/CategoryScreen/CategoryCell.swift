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
        view.layer.cornerRadius = 25
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 3
        return view
    } ()

    lazy var categoryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "Goodies Stars")
        return imageView
    }()

    lazy var levelNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .white
        label.textAlignment = .left
        label.text = "ТРЕНДЫ"
        label.font = UIFont(name: "Phosphate-Solid", size: 24)
        return label
    }()

    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .white
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.text = "Примеры из набора: гильза, сантиметр, баскетбол"
        label.font = UIFont(name: "Piazzolla", size: 16)
        return label
    }()

    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews:
                                [
                                    self.levelNameLabel,
                                    self.descriptionLabel
                                ])
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var cellStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews:
                                [
                                    self.categoryImageView,
                                    self.labelStackView
                                ])
        stackView.axis = .horizontal
        stackView.spacing = 0
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private func setupView () {
        self.addSubview(contentView)
        self.contentView.addSubview(self.baseView)
        self.baseView.addSubview(self.cellStackView)


        NSLayoutConstraint.activate([
            self.contentView.topAnchor.constraint(equalTo: self.topAnchor),
            self.contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),

            self.baseView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            self.baseView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,
                                                                                    constant: 16),
            self.baseView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,
                                                                                    constant: -16),
            self.baseView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,
                                                                                    constant: -10),

            self.cellStackView.topAnchor.constraint(equalTo: self.baseView.topAnchor),
            self.cellStackView.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor),
            self.cellStackView.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor),
            self.cellStackView.bottomAnchor.constraint(equalTo: self.baseView.bottomAnchor)

        ])
    }
}
