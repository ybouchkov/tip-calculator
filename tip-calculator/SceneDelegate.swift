//
//  SceneDelegate.swift
//  tip-calculator
//
//  Created by Yani Buchkov on 15.03.24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowSceen = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowSceen)
        // setup the root view controller - initial point
        let viewController = CalculatorViewController()
        window.rootViewController = viewController
        self.window = window
        window.makeKeyAndVisible()
    }
}

