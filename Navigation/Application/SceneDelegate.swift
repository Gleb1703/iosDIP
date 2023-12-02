//
//  SceneDelegate.swift
//  Navigation
//
//  Created by Created by gleb on 05/10/2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        UINavigationBar.configure()
        let mainCoordinator: MainCoordinator = MainCoordinatorImp()
        self.window = window
        window.rootViewController = mainCoordinator.startApplication()
        window.makeKeyAndVisible()
    }
}
