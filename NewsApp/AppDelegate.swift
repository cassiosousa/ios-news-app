import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        let navigation = UINavigationController()
        let browse = BrowseNewsViewController()
        navigation.pushViewController(browse, animated: false)
        window!.rootViewController = navigation
        window!.makeKeyAndVisible()
        return true
    }
}

