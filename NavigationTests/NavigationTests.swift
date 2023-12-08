//
//  NavigationTests.swift
//  NavigationTests
//
//  Created by Created by gleb on 05/10/2023.
//

import XCTest

final class NavigationTests: XCTestCase {
    
    var customButton: CustomButton!
    var profileViewController: ProfileViewController!
    let keychain = KeychainService.shared.keychain
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        profileViewController = ProfileViewController()
    }

    override func tearDownWithError() throws {
        
        customButton = nil
        profileViewController = nil
        try super.tearDownWithError()
    }
    
    func testPostModelCreation() throws {
        
        let posts = PostModel.own()
        
        // Проверяем, что в созданном массиве действительно 4 поста, и автора первого поста
        XCTAssertEqual(posts.count, 4)
        XCTAssertEqual(posts[0].author, "Apple Inc.")
    }
    
    func testCustomButton() throws {
    
        let color = UIColor.systemCyan
        let title = "Button"
        let titleColor = UIColor.white
        func forTesting() {}
        
        customButton = CustomButton(action: forTesting, title: title, style: .primary)
        
        // Проверяем параметры созданной кнопки
        XCTAssertEqual(customButton.titleLabel?.text, "Button")
        XCTAssertEqual(customButton.backgroundColor, UIColor(_colorLiteralRed: 61, green: 151, blue: 237, alpha: 1))
        XCTAssertEqual(customButton.titleLabel?.textColor, UIColor.white)
    }
    
    func testSignOut() throws {
        
        profileViewController.signOutButtonPressed()
        
        // Проверяем, что при вызове метода значение соответствующего ключа в KeyChain изменилось на "false"
        XCTAssertEqual(keychain["isSignedIn"], "false")
        
    }
}
