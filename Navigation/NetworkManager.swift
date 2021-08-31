//
//  NetworkManager.swift
//  Navigation
//
//  Created by Dima Gorbachev on 17.08.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation

struct NetworkManager {
    
    private static var session = URLSession.shared
    
    static func fetchData(config: AppConfiguration) {
        switch config {
        case .first(let url): self.dataTask(url: url) { (string) in
            print(string)
        }
        case .second(let url): self.dataTask(url: url) { (string) in
            print(string)
        }
        case .third(let url): self.dataTask(url: url) { (string) in
            print(string)
        }
        }
    }
    
    static func dataTask(url: URL, completion: @escaping (String) -> Void) {
        let task = session.dataTask(with: url) { (data, responce, error) in
            guard error == nil else {
                // код ошибки - 1009
                print(error!.localizedDescription)
                return
            }
            guard let httpResp = responce as? HTTPURLResponse, httpResp.statusCode == 200 else { return }
            print(httpResp.statusCode)
            print(httpResp.allHeaderFields as! [String: Any])
            if let data = data {
                if let temp = String(data: data, encoding: .utf8) {
                    completion(temp)
                }
            }
        }
        task.resume()
    }
    
    static func getTask(url: URL, completion: @escaping (String) -> Void) {
        let task = session.dataTask(with: url) { (data, responce, error) in
            successQuery(error: error, resp: responce)
            if let data = data {
                do {
                    if let jsonDict = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? Dictionary<String, Any> {
                        let task = Task(
                            userId: jsonDict["userId"] as! Int,
                            id: jsonDict["id"] as! Int,
                            title: jsonDict["title"] as! String,
                            isCompleted: jsonDict["completed"] as! Bool
                        )
                        completion(task.title)
                    }
                }
            }
        }
        task.resume()
    }
    
    static func getPlanet(url: URL, completion: @escaping (String, String) -> Void) {
        let task = session.dataTask(with: url) { (data, responce, error) in
            successQuery(error: error, resp: responce)
            if let data = data {
                do {
                    if let object = try? JSONDecoder().decode(Planet.self, from: data) {
                        completion(object.name, object.orbitalPeriod)
                    }
                }
            }
        }
        task.resume()
    }
    
    static func successQuery(error: Error?, resp: URLResponse? ) {
        guard error == nil else {
            print(error.debugDescription)
            return
        }
        guard let httpResp = resp as? HTTPURLResponse, httpResp.statusCode == 200 else { return }
    }
    
    // MARK: Эксперименты
    
    
    static func jsonDecoder(error: Error?, resp: URLResponse?, data: Data?, completion: @escaping (String) -> Void) {
        guard error == nil else {
            print(error.debugDescription)
            return
        }
        guard let httpResp = resp as? HTTPURLResponse, httpResp.statusCode == 200 else { return }
        if let data = data {
            do {
                if let object = try? JSONDecoder().decode(Planet.self, from: data) {
                    completion(object.orbitalPeriod)
                }
            }
        }
    }

    
    static func basicTask(url: URL, param: Int, completion: @escaping (String) -> Void) {
        let task = session.dataTask(with: url) { (data, responce, error) in
//            switch param {
//            case 1: self.forJson(error: data, resp: responce, data: data) { (string) in
//                completion(string)
//            }
//            case 2: successQuery(error: error, resp: responce)
//            default:
//                print("unknown case")
//            }
        }
        task.resume()
    }
}


enum AppConfiguration {
    case first(URL)
    case second(URL)
    case third(URL)
}
