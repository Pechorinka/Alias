//
//  WordsCheckView.swift
//  Alias
//
//  Created by Юлия Филимонова on 09.10.2022.
//

import UIKit

final class WordsCheckView: UIView {

    private lazy var teamLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "TEAM NAME"
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont(name: "Phosphate-Solid", size: 25)
        return label
    }()

    private lazy var wordsCheckTableView: UITableView = {
        let tableView = UITableView(frame: self.bounds, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(WordsCheckCell.self, forCellReuseIdentifier: "WordsCheckCell")
        tableView.backgroundColor = .white
        return tableView
    }()

    private lazy var scoreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "НАБРАНО ОЧКОВ:"
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont(name: "Phosphate-Solid", size: 25)
        return label
    }()

    private lazy var bottomButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .black
        button.setTitle("Далее", for: .normal)
        button.titleLabel?.font = UIFont(name: "Phosphate-Solid", size: 24)
        button.titleLabel?.textColor = .white
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(didTapBottomButton), for: .touchUpInside)
        return button
    }()

    @objc private func didTapBottomButton() {
        print("Продолжить игру!")
    }

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    private func setView() {[
        self.teamLabel,
        self.wordsCheckTableView,
        self.scoreLabel,
        self.bottomButton
    ].forEach { self.addSubview($0) }

        NSLayoutConstraint.activate([
            self.teamLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.teamLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),

            self.wordsCheckTableView.topAnchor.constraint(equalTo: self.teamLabel.bottomAnchor, constant: 3),
            self.wordsCheckTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.wordsCheckTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.wordsCheckTableView.bottomAnchor.constraint(equalTo: self.scoreLabel.topAnchor, constant: -5),

            self.scoreLabel.bottomAnchor.constraint(equalTo: self.bottomButton.topAnchor, constant: -3),
            self.scoreLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            self.bottomButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -11),
            self.bottomButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            self.bottomButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            self.bottomButton.heightAnchor.constraint(equalToConstant: 66)
        ])
    }
}

//MARK: - UITableViewDataSource

extension WordsCheckView: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WordsCheckCell", for: indexPath) as! WordsCheckCell
        return cell
    }

}

//MARK: - UITableViewDelegate

extension WordsCheckView: UITableViewDelegate {



}
