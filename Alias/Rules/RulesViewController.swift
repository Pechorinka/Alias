
import UIKit

class RulesViewController: UIViewController {

    private var navBarBackButtonHandler: (() -> Void)?
    private var bottomBackButtonHandler: (() -> Void)?
    private var imageName: String
    private var ruleText: String
    private var descriptionRuleText: String
    private var shouldBottomButtonVisible: Bool
    
    private lazy var ruleView = RulesView(
        imageName: self.imageName,
        descriptionRuleText: self.descriptionRuleText,
        ruleText: self.ruleText,
        navBarBackButtonHandler: self.navBarBackButtonHandler,
        bottomBackButtonHandler: self.bottomBackButtonHandler,
        shouldBottomButtonVisible: self.shouldBottomButtonVisible
    )
    
    init(
        imageName: String,
        ruleText: String,
        descriptionRuleText: String,
        shouldBottomButtonVisible: Bool = false,
        navBarBackButtonHandler: (() -> Void)?,
        bottomBackButtonHandler: (() -> Void)? = nil
        
    ) {
        self.imageName = imageName
        self.ruleText = ruleText
        self.descriptionRuleText = descriptionRuleText
        self.shouldBottomButtonVisible = shouldBottomButtonVisible
        self.navBarBackButtonHandler = navBarBackButtonHandler
        self.bottomBackButtonHandler = bottomBackButtonHandler
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = self.ruleView
    }
}
