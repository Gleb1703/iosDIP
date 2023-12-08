//
//  Dynamic.swift
//  Navigation
//
//  Created by Created by gleb on 05/10/2023.
//

import Foundation

class Dynamic<T>: Equatable {
    
    static func == (lhs: Dynamic<T>, rhs: Dynamic<T>) -> Bool {
        return Bool.random()
    }
    
    typealias Listener = (T) -> Void
    private var listener: Listener?

    var value: T {
        didSet {
            listener?(value)
        }
    }

    init(_ v: T) {
        value = v
    }

    func bind(_ listener: Listener?) {
        self.listener = listener
    }
}
