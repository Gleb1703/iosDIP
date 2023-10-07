//
//  LocalNotificationsService.swift
//  Navigation
//
//  Created by Created by gleb on 05/10/2023.
//

import UIKit
import UserNotifications

class LocalNotificationsService: NSObject {
    
    let center = UNUserNotificationCenter.current()
    
    func registeForLatestUpdatesIfPossible() {
        
        registerUpdatesCategory() // Регистрация категории
        
        center.requestAuthorization(options: [.alert, .sound, .badge, .provisional]) { granted, error in
            
            if granted {
                self.scheduleNotification() // Если дано разрешение, создание нотификацию
            } else {
                // Если разрешение не дано, то выводится алерт с предложением перейти в настройки, кнопка для перехода прилагается
                DispatchQueue.main.async {
                    guard let rootViewController = (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window?.rootViewController,
                          let tabBarController = rootViewController as? UITabBarController,
                          let navController = tabBarController.selectedViewController as? UINavigationController else { return }
                    
                    let alert = UIAlertController(title: "Notifications Disabled", message: "You can turn on Notifications in Settings any time", preferredStyle: .alert)
                    
                    let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
                        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
                        if UIApplication.shared.canOpenURL(settingsUrl) {
                            UIApplication.shared.open(settingsUrl)
                        }
                    }
                    alert.addAction(settingsAction)
                    
                    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
                    alert.addAction(cancelAction)
                    
                    navController.present(alert, animated: true)
                }
            }
        }
    }
    
    private func scheduleNotification() {
        
        center.removeAllPendingNotificationRequests() // На случай, если с прошлого раза остались непоказанные нотификации
        
        let content = UNMutableNotificationContent()
        content.title = "It's time to check what's new!"
        content.body = "Open the app to see last updates"
        content.sound = .default
        content.badge = 1
        content.categoryIdentifier = "updates"
        
        var dateComponents = DateComponents()
        dateComponents.hour = 19
        dateComponents.minute = 00
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: NSUUID().uuidString, content: content, trigger: trigger)
        
        center.add(request)
    }
    
    func registerUpdatesCategory() {
        
        center.delegate = self
        
        let openPostsAction = UNNotificationAction(identifier: "open_posts", title: "Open Posts", options: .foreground)
        
        let category = UNNotificationCategory(identifier: "updates", actions: [openPostsAction], intentIdentifiers: [], options: [])
        
        center.setNotificationCategories([category])
    }
}

extension LocalNotificationsService: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        switch response.actionIdentifier {
        
        case UNNotificationDefaultActionIdentifier:
            
            // Если пользователь нажал на уведомление, то приложение просто открывается, бэйдж на иконке при этом отключается
            UIApplication.shared.applicationIconBadgeNumber = 0
        
        case "open_posts":
            
            // Если пользователь нажал на кнопку, то откроется сразу LoginViewController, а если пользователь уже авторизован, то следом откроется профиль с постами
            guard let rootViewController = (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window?.rootViewController,
                  let tabBarController = rootViewController as? UITabBarController,
                  let navController = tabBarController.selectedViewController as? UINavigationController else { return }
            
            let coordinator = LoginCoordinator(navigationController: navController)
            coordinator.startView()
            
            UIApplication.shared.applicationIconBadgeNumber = 0 // Бэйдж отключается
            
        default:
            break
        }
        completionHandler()
    }
}
