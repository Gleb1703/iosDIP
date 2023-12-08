//
//  CustomButton.swift
//  Navigation
//
//  Created by Created by gleb on 05/10/2023.
//

import UIKit

class LoginButton: UIButton {

    override open var isHighlighted: Bool {
        didSet {
            alpha = isHighlighted ? 0.8 : 1.0
        }
    }

    override open var isSelected: Bool {
        didSet {
            alpha = isSelected ? 0.8 : 1.0
        }
    }

    override open var isEnabled: Bool {
        didSet {
            alpha = isEnabled ? 1 : 0.8
        }
    }
}
