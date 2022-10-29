
import UIKit
import SkeletonView

final class CategoryView: UIView {
    var cellSet = Set<Int>()
    var nextVC: (() -> Void)?
    
    var categories = [CategoryModel]() {
        didSet {
            self.showSkeletonGradientAnimation(false)
            self.categoryTableView.reloadData()
        }
    }

    private lazy var categoryTableView: UITableView = {
        let tableView = UITableView(frame: self.bounds, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsMultipleSelection = true
        tableView.register(CategoryCell.self, forCellReuseIdentifier: "CategoryCell")
        tableView.backgroundColor = .white
        return tableView
    }()

    private lazy var bottomButton = CustomButton(color: .black,
                                                 title: "ДАЛЕЕ",
                                                 titleColor: .white,
                                                 buttonHandler: {
        [weak self] in
        guard let self = self else { return }
        self.nextVC?()
    })
    
    private let viewModel: CategoryChoiceModel
    
    private lazy var buttonHeightConstraint = self.bottomButton.heightAnchor.constraint(equalToConstant: 0.0)
    
    init(viewModel: CategoryChoiceModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        self.setView()
        self.showButton()
        
        self.categoryTableView.isSkeletonable = true
        self.isSkeletonable = true
        
        self.showSkeletonGradientAnimation()
    }
    
    func showSkeletonGradientAnimation(_ isShow: Bool = true) {
        if isShow {
            let animation = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .topLeftBottomRight)
            self.showAnimatedGradientSkeleton(
                usingGradient: .init(
                    baseColor: UIColor(named: "RoyalBlueColor")!,
                    secondaryColor: UIColor(named: "DarkPurpleColor")!),
                animation: animation,
                transition: .crossDissolve(0.25)
            )
        } else {
            self.hideSkeleton(transition: .crossDissolve(0.25))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setView() {[
        self.categoryTableView,
        self.bottomButton
    ].forEach { self.addSubview($0) }
        self.bottomButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.categoryTableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.categoryTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.categoryTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.categoryTableView.bottomAnchor.constraint(equalTo: self.bottomButton.topAnchor, constant: -5),

            self.bottomButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -11),
            self.bottomButton.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            self.buttonHeightConstraint
        ])
    }
    
    private func showButton() {
        self.buttonHeightConstraint.constant = self.cellSet.isEmpty ? 0 : 66
    }

}

//MARK: - UITableViewDataSource

extension CategoryView: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.categories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        
        cell.hideSkeleton(transition: .crossDissolve(0.25))
        cell.configureCell(cell: self.categories[indexPath.row])
        
        if self.cellSet.contains(indexPath.row) {
            cell.createGradientBorder()
        } else {
            self.cellSet.remove(indexPath.row)
            cell.deleteGradientBorder()
        }
        
        self.showButton()

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
}

// MARK: - Handle row tap
extension CategoryView {
    
    func handleRowTapForClassicGame(_ indexPath: IndexPath) {
        let rowIndex = indexPath.row
        
        if self.cellSet.contains(rowIndex) {
            self.cellSet.remove(rowIndex)
        } else {
            self.cellSet.insert(rowIndex)
        }
    }
    
    func handleRowTapForThemeGame(_ indexPath: IndexPath) {
        let rowIndex = indexPath.row
        
        let isMixCategoryWasChoosen = self.viewModel.isMixCategoryChoosen(self.cellSet)
        let currentlyTapCategory = self.categories[rowIndex]
        
        if (isMixCategoryWasChoosen && !currentlyTapCategory.isMixCategory) ||
           (!isMixCategoryWasChoosen && currentlyTapCategory.isMixCategory) {
            self.cellSet = [rowIndex]
            return
        }
        
        if self.cellSet.contains(rowIndex) {
            self.cellSet.remove(rowIndex)
        } else {
            self.cellSet.insert(rowIndex)
        }
        
        if !isMixCategoryWasChoosen && self.cellSet.count == self.categories.count - 1 {
            self.cellSet = [self.categories.count - 1]
            return
        }
    }
    
}

//MARK: - UITableViewDelegate

extension CategoryView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer {
            self.categoryTableView.reloadData()
        }
        
        switch self.viewModel.wordsSetType  {
        case .classic:
            self.handleRowTapForClassicGame(indexPath)
        case .theme:
            self.handleRowTapForThemeGame(indexPath)
        case .none:
            break
        }
    }
}

// MARK: - SkeletonTableViewDataSource
extension CategoryView: SkeletonTableViewDataSource {

    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }

    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        "CategoryCell"
    }

}
