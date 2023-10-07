//
//  LoginFactory.swift
//  Navigation
//
//  Created by Created by gleb on 05/10/2023.
//

import Foundation

protocol LoginFactory {
    
    func makeLoginInspector() -> LoginInspector
}

struct MyLoginFactory: LoginFactory {
    
    func makeLoginInspector() -> LoginInspector {
        LoginInspector()
    }
}
