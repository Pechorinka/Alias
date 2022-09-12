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


    private lazy var gradientView: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor(named: "DarkPurpleColor")!.cgColor,
                           UIColor(named: "OrangeColor")!.cgColor,
                           UIColor(named: "RoyalBlueColor")!.cgColor,
                           UIColor(named: "SignalOrangeColor")!.cgColor,
                           UIColor(named: "PersianBlueColor")!.cgColor]
        return gradient
    }()

    private lazy var gradientShape: CAShapeLayer = {
        let shape = CAShapeLayer()
        shape.lineWidth = 4
        shape.path = UIBezierPath(roundedRect: CGRect(x: 2,y: 2,
                                                      width:  self.baseView.bounds.width - 4,
                                                      height: self.baseView.bounds.height - 4),
                                                      cornerRadius: 21).cgPath
        shape.strokeColor = UIColor.black.cgColor
        shape.fillColor = UIColor.clear.cgColor
        return shape
    }()

    func configureCell(cell: DifficultyPage) {
        self.categoryImageView.image = UIImage(named: cell.image)
        self.levelNameLabel.text = cell.level
        self.descriptionLabel.text = cell.description
        self.exampleLabel.text = cell.example
    }


    func createGradientBorder() {
        self.gradientView.frame = self.baseView.bounds
        self.gradientView.mask = self.gradientShape
        self.baseView.layer.addSublayer(gradientView)
    }

    func deleteGradientBorder() {
        self.baseView.layer.sublayers?.removeLast()
    }

    func createMonochromeBorder() {
       self.baseView.layer.borderWidth = 4
       self.baseView.layer.borderColor = UIColor(named: "RoyalBlueColor")?.cgColor
    }

    func deleteMonochromeBorder() {
        self.baseView.layer.borderWidth = 0
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
