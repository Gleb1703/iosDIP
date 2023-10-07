//
//  Factory.swift
//  Navigation
//
//  Created by Created by gleb on 05/10/2023.
//

import Foundation
import UIKit

class Factory {

    enum Views {
        case feed
        case login
    }

    let navigationController: UINavigationController
    let viewController: Views

    init(navigationController: UINavigationController, viewController: Views) {
        self.navigationController = navigationController
        self.viewController = viewController
        startModule()
    }

    func startModule() {
        switch viewController {
        case .feed:
            let feedCoordinator = FeedCoordinator(navigationController: navigationController)
            let controller = FeedViewController(coordinator: feedCoordinator)
            navigationController.tabBarItem = .init(title: "Feed", image: UIImage(systemName: "doc.text"), tag: 0)
            navigationController.setViewControllers([controller], animated: true)
        case .login:
            let loginCoordinator = LoginCoordinator(navigationController: navigationController)
            let controller = LogInViewController(coordinator: loginCoordinator)
            controller.loginDelegate = MyLoginFactory().makeLoginInspector()
            navigationController.tabBarItem = .init(title: "Profile", image: UIImage(systemName: "person.crop.circle"), tag: 1)
            navigationController.setViewControllers([controller], animated: true)
        }
    }
}
