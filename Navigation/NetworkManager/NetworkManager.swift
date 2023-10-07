//
//  NetworkManager.swift
//  Navigation
//
//  Created by Created by gleb on 05/10/2023.
//

import Foundation

struct NetworkManager {

    static func dataTask(_ address: URL) {
        let session = URLSession.shared
        let task = session.dataTask(with: address) { data, response, error in

            if let error = error {
                print("Error occurred: \(error.localizedDescription.debugDescription)")
                // Code=-1009 "The Internet connection appears to be offline.
            } else {
                guard let data = data else { return }
                let string = String(decoding: data, as: UTF8.self)
                print("Received data: \(string)")

                if let response = response as? HTTPURLResponse {
                    print("Full response: \(response.allHeaderFields), status code: \(response.statusCode)")
                }
            }
        }
        task.resume()
    }
}
