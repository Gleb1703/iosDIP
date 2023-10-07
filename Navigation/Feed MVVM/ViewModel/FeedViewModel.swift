//
//  FeedViewModel.swift
//  Navigation
//
//  Created by Created by gleb on 05/10/2023.
//

import Foundation
import UIKit

class FeedViewModel: UIViewController {

    var statusText = Dynamic("")
    var statusColor = Dynamic(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))

    func buttonPressed(word: String) {
        if word != "" {
            if word != Word.words[0].secretWord {
                statusText.value = "-"
                statusColor.value = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            } else {
                statusText.value = "+"
                statusColor.value = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            }
        } else {
            statusText.value = "?"
            statusColor.value = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        }
    }
}
