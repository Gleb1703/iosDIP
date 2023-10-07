//
//  AlertModel.swift
//  Navigation
//
//  Created by Created by gleb on 05/10/2023.
//

import Foundation
import UIKit

class AlertModel {

    static let shared = AlertModel()
    let checkerService = CheckerService()

    func showOkActionAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        UIApplication.topViewController()?.present(alert, animated: true, completion: nil)
    }

    func showTwoActionAlert(title: String, message: String, okAction: String, cancelAction: String, handler: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: okAction, style: .default, handler: handler)
        let cancelAction = UIAlertAction(title: cancelAction, style: .cancel)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        UIApplication.topViewController()!.present(alert, animated: true, completion: nil)
    }
}

extension UIApplication {
    class func topViewController(controller: UIViewController? = UIApplication.shared.connectedScenes
          .filter({$0.activationState == .foregroundActive})
          .compactMap({$0 as? UIWindowScene})
          .first?.windows
          .filter({$0.isKeyWindow})
          .first?.rootViewController) -> UIViewController? {

        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}
