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

    lazy var baseView: UIView = {
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
        imageView.image = UIImage(named: "Goodies Fire")
        return imageView
    }()

    lazy var levelNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .white
        label.textAlignment = .left
        label.text = "ТРЕНДЫ"
        label.textColor = UIColor(named: "RoyalBlueColor")
        label.font = UIFont(name: "Phosphate-Solid", size: 26)
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
        label.text = "Набор из оригинальной настольной игры. Содержит слова и словосочетания разной сложности."
        label.font = UIFont(name: "Piazzolla", size: 15)
        return label
    }()

    var exampleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .white
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.text = "Примеры из набора: гильза, сантиметр, баскетбол"
        label.font = UIFont(name: "Piazzolla", size: 14)
        return label
    }()

    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews:
                                [
                                    self.levelNameLabel,
                                    self.descriptionLabel,
                                    self.exampleLabel
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

    func configureCell(cell: DifficultyPage) {
        self.categoryImageView.image = UIImage(named: cell.image)
        self.levelNameLabel.text = cell.level
        self.descriptionLabel.text = cell.description
        self.exampleLabel.text = cell.example
    }

    func tapGradient() {
        let gradient = CAGradientLayer()
//        gradient.frame =  CGRect(origin: .zero, size: self.baseView.bounds.size)
        gradient.frame = self.baseView.bounds
        gradient.cornerRadius = 25
        gradient.colors = [UIColor.blue.cgColor, UIColor.green.cgColor]

        let shape = CAShapeLayer()
        shape.lineWidth = 10
        shape.path = UIBezierPath(rect: self.baseView.bounds).cgPath
        shape.strokeColor = UIColor.black.cgColor
        shape.fillColor = UIColor.clear.cgColor
        gradient.mask = shape

        self.baseView.layer.addSublayer(gradient)

        DispatchQueue.main.asyncAfter(deadline: .now()+0.15) {
            self.baseView.layer.sublayers?.removeLast()

        }
    }

    private func setupView () {
        self.addSubview(contentView)
        self.contentView.addSubview(self.baseView)

        [
            self.categoryImageView,
            self.labelStackView
        ].forEach { self.addSubview($0) }

        //        self.baseView.addSubview(self.cellStackView)

        NSLayoutConstraint.activate([
            self.contentView.topAnchor.constraint(equalTo: self.topAnchor),
            self.contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),

            self.baseView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            self.baseView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.baseView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            self.baseView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10),

            self.categoryImageView.heightAnchor.constraint(equalToConstant: 100),
            self.categoryImageView.widthAnchor.constraint(equalToConstant: 100),
            self.categoryImageView.topAnchor.constraint(equalTo: self.baseView.topAnchor, constant: 15),
            self.categoryImageView.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 10),

            self.levelNameLabel.heightAnchor.constraint(equalToConstant: 25),
            self.labelStackView.topAnchor.constraint(equalTo: self.baseView.topAnchor, constant: 15),
            self.labelStackView.bottomAnchor.constraint(equalTo: self.baseView.bottomAnchor, constant:  -10),
            self.labelStackView.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor, constant: -5),
            self.labelStackView.leadingAnchor.constraint(equalTo: self.categoryImageView.trailingAnchor, constant: 15),

//            self.cellStackView.topAnchor.constraint(equalTo: self.baseView.topAnchor),
//            self.cellStackView.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor),
//            self.cellStackView.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor),
//            self.cellStackView.bottomAnchor.constraint(equalTo: self.baseView.bottomAnchor)

        ])
    }
}
