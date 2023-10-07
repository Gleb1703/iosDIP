//
//  MainCoordinator.swift
//  Navigation
//
//  Created by Created by gleb on 05/10/2023.
//

import Foundation
import UIKit

protocol MainCoordinator {
    func startApplication() -> UIViewController
}

class MainCoordinatorImp: MainCoordinator {
    func startApplication() -> UIViewController {
        return TabBarController()
    }
}
