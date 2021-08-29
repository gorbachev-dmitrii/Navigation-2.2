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
            print(string!)
        }
        case .second(let url): self.dataTask(url: url) { (string) in
            print(string!)
        }
        case .third(let url): self.dataTask(url: url) { (string) in
            print(string!)
        }
        }
    }
    
    static func dataTask(url: URL, completion: @escaping (String?) -> Void) {
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
                completion(String(data: data, encoding: .utf8))
            }
        }
        task.resume()
    }
    
}


enum AppConfiguration {
    case first(URL)
    case second(URL)
    case third(URL)
}
