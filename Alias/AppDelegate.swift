
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white

//        window?.rootViewController = AppNavigationController(rootViewController: StartMenuViewController())

        window?.rootViewController = AppNavigationController(rootViewController: ResultScreenViewController(finalists: [Team(name: "jdgdjgn", scores: 20)]))
        window?.makeKeyAndVisible()
        
        return true
    }
}

