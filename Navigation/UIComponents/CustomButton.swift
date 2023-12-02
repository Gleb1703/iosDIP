//
//  CustomButton.swift
//  Navigation
//
//  Created by Created by gleb on 05/10/2023.
//

import Foundation
import UIKit

class CustomButton: UIButton {

    enum Style {
        case primary
        case secondary
        case danger
    }
    
    private let buttonAction: () -> ()
    
    init(
        action: @escaping () -> (),
        title: String,
        style: Style,
        textSize: CGFloat = 16
    ) {
        self.buttonAction = action
        super.init(frame: .zero)
        setAttributedTitle(.gilroySemiBold(string: title, size: textSize), for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 10
        
        switch style {
        case .primary:
            backgroundColor = .accentPrimary
            setTitleColor(.white, for: .normal)
            break
        case .secondary:
            backgroundColor = .white
            setTitleColor(.accentPrimary, for: .normal)
            break
        case .danger:
            backgroundColor = .systemPink
            setTitleColor(.white, for: .normal)
            break
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup() {
        sizeToFit()
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        self.center = center
    }

    @objc func buttonTapped() {
        buttonAction()
    }
}
