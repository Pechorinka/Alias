//
//  CategoryView.swift
//  Alias
//
//  Created by Юлия Филимонова on 06.09.2022.
//

import UIKit

final class CategoryView: UIView {

    var categories = ["","","","","",""]


    private lazy var categoryTableView: UITableView = {
        let tableView = UITableView(frame: self.bounds, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CategoryCell.self, forCellReuseIdentifier: "CategoryCell")
        return tableView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setView() 
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    private func setView() {
       self.addSubview( self.categoryTableView)

        NSLayoutConstraint.activate([
            self.categoryTableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.categoryTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.categoryTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.categoryTableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

//MARK: - UITableViewDataSource

extension CategoryView: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryCell

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }


}

//MARK: - UITableViewDelegate

extension CategoryView: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {


        if let cell = tableView.cellForRow(at: indexPath) as? CategoryCell {
            cell.createGradientBorder()
        }

    }

}
