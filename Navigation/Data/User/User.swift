//
//  User.swift
//  Navigation
//
//  Created by Created by gleb on 05/10/2023.
//

import Foundation
import UIKit

protocol UserService {
    
    func loginCheck(login: String) -> User?
}

class User {
    
    var login: String
    var fullName: String
    var avatar: UIImage?
    var status: String
    
    init(login: String, fullName: String, avatar: UIImage?, status: String) {
        self.login = login
        self.fullName = fullName
        self.avatar = avatar
        self.status = status
    }
}

enum Users {
    case main
    case test
    
    var instance: User {
        switch self {
        case .main:
            return User(login: "main", fullName: "Steve Jobs", avatar: UIImage(named: "steve"), status: "Stay hungry, stay foolish")
        case .test:
            return User(login: "test", fullName: "Test User", avatar: UIImage(named: "test"), status: "Test Status")
        }
    }
}


