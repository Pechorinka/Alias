//
//  CategoryViewController.swift
//  Alias
//
//  Created by Юлия Филимонова on 06.09.2022.
//

import UIKit

class CategoryViewController: CustomViewController {

    override var nameViewControler: String { "КАТЕГОРИИ" }
    let choiceModel = DifficultyChoiceModel()
    private lazy var categoryView = CategoryView(categories: self.categories)


    private var categories: [CategoryModel] = [] {
        didSet {
            self.categoryView.categories = self.categories
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        self.categoryView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.categoryView)

        NSLayoutConstraint.activate([
            self.categoryView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.categoryView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.categoryView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.categoryView.topAnchor.constraint(equalTo: self.customNavigationBarView.bottomAnchor, constant: 5)
        ])

        self.choiceModel.loadCategories { categories in
            self.categories = categories
        }
    }


}

