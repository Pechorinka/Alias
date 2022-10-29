
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        
//        let rootVC: UIViewController = {
//            let isFirstAppStartup = Core.shared.isFirstAppStartup
//            if isFirstAppStartup {
//                return RulesViewOnebording(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
//            } else {
//                return StartMenuViewController()
//            }
//        }()
        
        window?.rootViewController = AppNavigationController(rootViewController: StartMenuViewController())

//        window?.rootViewController = AppNavigationController(rootViewController: rootVC)
//        window?.rootViewController = WordsCheckViewController()
        window?.makeKeyAndVisible()
        
        return true
    }
}

