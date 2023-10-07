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
        
        let posts = PostModel.make()
        
        // Проверяем, что в созданном массиве действительно 4 поста, и автора первого поста
        XCTAssertEqual(posts.count, 4)
        XCTAssertEqual(posts[0].author, "Apple Inc.")
    }
    
    func testCustomButton() throws {
    
        let color = UIColor.systemCyan
        let title = "Button"
        let titleColor = UIColor.white
        func forTesting() {}
        
        customButton = CustomButton(action: forTesting, color: color, title: title, titleColor: titleColor)
        
        // Проверяем параметры созданной кнопки
        XCTAssertEqual(customButton.titleLabel?.text, "Button")
        XCTAssertEqual(customButton.backgroundColor, UIColor.systemCyan)
        XCTAssertEqual(customButton.titleLabel?.textColor, UIColor.white)
    }
    
    func testSignOut() throws {
        
        profileViewController.didTapSignOut()
        
        // Проверяем, что при вызове метода значение соответствующего ключа в KeyChain изменилось на "false"
        XCTAssertEqual(keychain["isSignedIn"], "false")
        
    }
}
