//
//  JSONModel.swift
//  Navigation
//
//  Created by Created by gleb on 05/10/2023.
//

import Foundation

/*
 {
     "userId": 1,
     "id": 1,
     "title": "delectus aut autem",
     "completed": false
   }
 */

struct Planets: Decodable {
    let orbitalPeriod: String
    let residents: [String]

    enum CodingKeys: String, CodingKey {
        case orbitalPeriod = "orbital_period"
        case residents
    }
}

struct Residents: Decodable {
    let name: String
}

// MARK: - Task 1

func getTitle(completion: ((_ title: String?) -> Void)? ) {

    let session = URLSession(configuration: .default)
    guard let url = URL(string: "https://jsonplaceholder.typicode.com/todos/\(Int.random(in: 1...200))") else { return }
    let task = session.dataTask(with: url) { data, response, error in

        if let error {
            print(error.localizedDescription)
            completion?(nil)
            return
        }

        if (response as! HTTPURLResponse).statusCode != 200 {
            print("Status code: \(response as! HTTPURLResponse).statusCode)")
            completion?(nil)
            return
        }

        guard let data else {
            print("No data")
            completion?(nil)
            return
        }
        do {
            if let json = try JSONSerialization.jsonObject(with: data) as? [String : Any] {
                guard let title = json["title"] as? String else { return }
                completion?(title)
            }
        } catch let error as NSError {
            print("Error: \(error.localizedDescription)")
        }
    }
    task.resume()
}

// MARK: - Task 2

func getRotationPeriod(completion: ((_ period: String?) -> Void)? ) {

    let session = URLSession(configuration: .default)
    guard let url = URL(string: "https://swapi.dev/api/planets/1") else { return }

    let task = session.dataTask(with: url) { data, response, error in

        if let error {
            print(error.localizedDescription)
            completion?(nil)
            return
        }

        if (response as! HTTPURLResponse).statusCode != 200 {
            print("Invalid status code: \((response as! HTTPURLResponse).statusCode)")
            completion?(nil)
            return
        }

        guard let data else {
            print("Data is empty")
            completion?(nil)
            return
        }

        do {
            let answer = try JSONDecoder().decode(Planets.self, from: data)
            completion?(answer.orbitalPeriod)
        } catch let error as NSError {
            print("Error: \(error.localizedDescription)")
        }
    }
    task.resume()
}

// MARK: - Task 3*

func getResidentsArray(completion: ((_ residentsArray: [String]?) -> Void)? ) {

    guard let url = URL(string: "https://swapi.dev/api/planets/1") else { return }
    let session = URLSession(configuration: .default)
    let task = session.dataTask(with: url) { data, response, error in

        if let error {
            print(error.localizedDescription)
            completion?(nil)
            return
        }

        if (response as! HTTPURLResponse).statusCode != 200 {
            print("Status code != 200. Status code: \((response as! HTTPURLResponse).statusCode)")
            completion?(nil)
            return
        }

        guard let data else {
            print("No data")
            completion?(nil)
            return
        }
        do {
            let answer = try JSONDecoder().decode(Planets.self, from: data)
            completion?(answer.residents)
            return
        } catch let error as NSError {
            print("Error: \(error.localizedDescription)")
        }
    }
    task.resume()
}
