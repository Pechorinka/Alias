//
//  WordsCheckViewController.swift
//  Alias
//
//  Created by Юлия Филимонова on 09.10.2022.
//

import UIKit

class WordsCheckViewController: CustomViewController {

    override var nameViewControler: String { "CЧЕТ РАУНДА" }
    private lazy var wordsCheckView = WordsCheckView()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.wordsCheckView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.wordsCheckView)

        NSLayoutConstraint.activate([
            self.wordsCheckView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.wordsCheckView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.wordsCheckView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.wordsCheckView.topAnchor.constraint(equalTo: self.customNavigationBarView.bottomAnchor, constant: 5)
        ])

    }

}
