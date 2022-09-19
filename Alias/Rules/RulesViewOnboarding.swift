
import UIKit

class RulesViewOnebording: UIPageViewController {
    
    private let rulesModel = RulesModel()
    private let initialPage = 0
    private let pageControl = UIPageControl()
    private var buttonHandler: (() -> Void)?
    private var pages = [UIViewController]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setup()
    }
}
    
extension RulesViewOnebording {
    
    private func setup() {
        dataSource = self
        delegate = self
        
        self.pageControl.addTarget(self, action: #selector(pageControlTapped(_:)), for: .valueChanged)
        
        for model in self.rulesModel.models {
            let page = RulesViewController(imageName: model.imageName,
                                           ruleText: model.ruleText,
                                           descriptionRuleText: model.descriptionRuleText,
                                           shouldBottomButtonVisible: model.shouldBottomButtonVisible,
                                           navBarBackButtonHandler: {
                [weak self] in
                self?.dismiss(animated: true)
            },
                                           bottomBackButtonHandler: {
                [weak self] in
                Core.shared.setIsNotFirstAppStartup()
                let vc = StartMenuViewController()
                self?.navigationController?.pushViewController(vc, animated: true)
                self?.dismiss(animated: true)
            })
            
            self.pages.append(page)
        }
        
        setViewControllers([self.pages[self.initialPage]], direction: .forward, animated: true, completion: nil)
        
        self.pageControl.translatesAutoresizingMaskIntoConstraints = false
        self.pageControl.currentPageIndicatorTintColor = UIColor(named: "RoyalBlueColor")
        self.pageControl.pageIndicatorTintColor = .lightGray
        self.pageControl.backgroundStyle = .minimal
        self.pageControl.backgroundColor = UIColor(named: "ShadowColor")
        self.pageControl.layer.cornerRadius = 12.0
        self.pageControl.numberOfPages = self.pages.count
        self.pageControl.currentPage = self.initialPage
        
        view.addSubview(self.pageControl)
        
        NSLayoutConstraint.activate([
            self.pageControl.heightAnchor.constraint(equalToConstant: 25),
            self.pageControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.view.safeAreaLayoutGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: self.pageControl.bottomAnchor, multiplier: 1)
        ])
    }
}

// MARK: - DataSource
extension RulesViewOnebording: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = self.pages.firstIndex(of: viewController) else { return nil }
        
        if currentIndex == 0 {
            return self.pages.last               // wrap last
        } else {
            return self.pages[currentIndex - 1]  // go previous
        }
    }
        
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let currentIndex = self.pages.firstIndex(of: viewController) else { return nil }

        if currentIndex < self.pages.count - 1 {
            return self.pages[currentIndex + 1]  // go next
        } else {
            return self.pages.first              // wrap first
        }
    }
}

// MARK: - Delegates
extension RulesViewOnebording: UIPageViewControllerDelegate {
    
    // How we keep our pageControl in sync with viewControllers
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        guard let viewControllers = pageViewController.viewControllers else { return }
        guard let currentIndex = self.pages.firstIndex(of: viewControllers[0]) else { return }
        
        self.pageControl.currentPage = currentIndex
    }
}

// MARK: - Actions

extension RulesViewOnebording {

    @objc func pageControlTapped(_ sender: UIPageControl) {
        setViewControllers([self.pages[sender.currentPage]], direction: .forward, animated: true, completion: nil)
    }

    @objc func skipTapped(_ sender: UIButton) {
        let lastPageIndex = self.pages.count - 1
        self.pageControl.currentPage = lastPageIndex
        
        self.goToSpecificPage(index: lastPageIndex, ofViewControllers: self.pages)
    }
    
    @objc func nextTapped(_ sender: UIButton) {
        self.pageControl.currentPage += 1
        self.goToNextPage()
    }
}

// MARK: - Extensions

extension UIPageViewController {

    func goToNextPage(animated: Bool = true, completion: ((Bool) -> Void)? = nil) {
        guard let currentPage = viewControllers?[0] else { return }
        guard let nextPage = dataSource?.pageViewController(self, viewControllerAfter: currentPage) else { return }
        
        setViewControllers([nextPage], direction: .forward, animated: animated, completion: completion)
    }
    
    func goToPreviousPage(animated: Bool = true, completion: ((Bool) -> Void)? = nil) {
        guard let currentPage = viewControllers?[0] else { return }
        guard let prevPage = dataSource?.pageViewController(self, viewControllerBefore: currentPage) else { return }
        
        setViewControllers([prevPage], direction: .forward, animated: animated, completion: completion)
    }
    
    func goToSpecificPage(index: Int, ofViewControllers pages: [UIViewController]) {
        setViewControllers([pages[index]], direction: .forward, animated: true, completion: nil)
    }
}
