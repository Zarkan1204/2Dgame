//
//  SceneDelegate.swift
//  2Dgame
//
//  Created by Мой Macbook on 13.02.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.makeKeyAndVisible()
        let navigationController = UINavigationController(rootViewController: MainViewController())
        window?.rootViewController = navigationController
    }
}

