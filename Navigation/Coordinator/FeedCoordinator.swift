//
//  FeedCoordinator.swift
//  Navigation
//
//  Created by Created by gleb on 05/10/2023.
//

import Foundation
import UIKit

class FeedCoordinator {

    let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func startView() {
        let feedCoordinator = FeedCoordinator(navigationController: navigationController)
        let feedViewController = FeedViewController(coordinator: feedCoordinator)
        navigationController.pushViewController(feedViewController, animated: true)
    }
}
