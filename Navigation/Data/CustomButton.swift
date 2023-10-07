//
//  CustomButton.swift
//  Navigation
//
//  Created by Created by gleb on 05/10/2023.
//

import Foundation
import UIKit

class CustomButton: UIButton {

    private let buttonAction: () -> ()

    init(
        action: @escaping () -> (),
        color: UIColor,
        title: String,
        titleColor: UIColor
    ) {
        self.buttonAction = action
        super.init(frame: .zero)

        backgroundColor = color
        setTitle(title, for: .normal)
        setTitleColor(titleColor, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
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
