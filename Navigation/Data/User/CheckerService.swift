//
//  CheckerService.swift
//  Navigation
//
//  Created by Created by gleb on 05/10/2023.
//

import Foundation
//import FirebaseAuth
//import RealmSwift

protocol CheckerServiceProtocol {
    func checkCredentials(email: String, password: String)
    func signUp(email: String, password: String)
}

class CheckerService: CheckerServiceProtocol {

    let appDelegate = AppDelegate()
    
    static let shared = CheckerService()

    var isSignedIn: Bool = false

//    var users = [Credentials]()
//    let service = Service()

    func checkCredentials(email: String, password: String) {
//        Auth.auth().signIn(withEmail: email, password: password) { [self] result, error in
//
//            if let error = error {
//                print("error: \(error)")
//                let error = error as NSError
//                switch error.code {
//
//                case AuthErrorCode.userNotFound.rawValue:
//                    AlertModel.shared.showTwoActionAlert(title: "User Not Found", message: "Do you want do sign up?", okAction: "Continue", cancelAction: "Cancel") { [self] _ in
//                        signUp(email: email, password: password)
//                    }
//                default:
//                    AlertModel.shared.showOkActionAlert(title: "Error", message: "Unable to sign in")
//                }
//            } else {
//                NotificationCenter.default.post(name: Notification.Name("Login successful"), object: isSignedIn)
//                isSignedIn = true
//            }
//        }
    }

    func signUp(email: String, password: String) {
//        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) { result, error in
//            if let error {
//                AlertModel.shared.showOkActionAlert(title: "Attention", message: "Unable to sign up")
//                print(error.localizedDescription)
//            } else {
//                AlertModel.shared.showOkActionAlert(title: "Success", message: "You've been signed up")
//            }
//        }
    }
}

extension CheckerService {
    
    func signInWithRealm(login: String, password: String) {
        
//        let config = Realm.Configuration(encryptionKey: appDelegate.getKey())
//
//        do {
//            let realm = try Realm(configuration: config)
//            let realmUsers = realm.objects(Credentials.self)
//
//            users = Array(realmUsers)
//
//            let currentUser = users.first { user in
//                user.login == login
//            }
//
//            if currentUser != nil {
//                if currentUser?.password == password {
//                    NotificationCenter.default.post(name: Notification.Name("Login successful"), object: isSignedIn)
//                    isSignedIn = true
//                    let keychain = KeychainService.shared.keychain
//                    keychain["isSignedIn"] = "true"
//                } else {
//                    AlertModel.shared.showOkActionAlert(title: "Attention", message: "Password is wrong")
//                }
//            } else {
//                AlertModel.shared.showTwoActionAlert(title: "User Not Found", message: "Do you want to sign up?", okAction: "Continue", cancelAction: "Cancel") { [self] _ in
//                    service.createUser(login: login, password: password)
//                    NotificationCenter.default.post(name: Notification.Name("Login successful"), object: isSignedIn)
//                    isSignedIn = true
//                    let keychain = KeychainService.shared.keychain
//                    keychain["isSignedIn"] = "true"
//                    AlertModel.shared.showOkActionAlert(title: "Success", message: "You have been signed up")
//                }
//            }
//        } catch let error as NSError {
//            fatalError("Error opening realm: \(error)")
//        }
    }
}
