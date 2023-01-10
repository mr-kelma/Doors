//
//  SceneDelegate.swift
//  Doors
//
//  Created by Valery Keplin on 10.01.23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let viewController = ViewController()
        
        let navigatorController = UINavigationController(rootViewController: viewController)
        navigatorController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigatorController.navigationBar.shadowImage = UIImage()
        navigatorController.navigationBar.isTranslucent = true

        window?.rootViewController = navigatorController
        window?.makeKeyAndVisible()
    }
}
