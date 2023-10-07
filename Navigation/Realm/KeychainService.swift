//
//  KeychainService.swift
//  Navigation
//
//  Created by Created by gleb on 05/10/2023.
//

import Foundation
import KeychainAccess

class KeychainService {
    static let shared = KeychainService()
    let keychain = Keychain(service: "Realm")
}
