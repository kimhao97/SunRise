import UIKit

class SceneDelegate: UIResponder,
                  UIWindowSceneDelegate {
    
    var window: UIWindow?
    let tabBarController = UITabBarController()
    
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        
        window?.makeKeyAndVisible()

        createTabBar()
    }
    
    func createTabBar() {
        let homeNavi = UINavigationController(rootViewController: HomeViewController())
        homeNavi.tabBarItem.image = UIImage(named: "ic-home-white")
        homeNavi.navigationBar.barTintColor = .black
        
        
        let libraryNavi = UINavigationController(rootViewController: LibraryViewController())
        libraryNavi.tabBarItem.image = UIImage(named: "ic-library-white")
        libraryNavi.navigationBar.barTintColor = .black
        libraryNavi.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 25)!,
            NSAttributedString.Key.foregroundColor: UIColor.white]
        
        let searchNavi = UINavigationController(rootViewController: SearchViewController())
        searchNavi.tabBarItem.image = UIImage(named: "ic-search-white")
        searchNavi.navigationBar.barTintColor = .black
        
        tabBarController.viewControllers = [homeNavi, libraryNavi, searchNavi]
        tabBarController.tabBar.tintColor = .white
        tabBarController.tabBar.isTranslucent = false
        tabBarController.tabBar.barTintColor = UIColor(hex: "#1C2329FF")
        
        window?.rootViewController = tabBarController
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}
}
