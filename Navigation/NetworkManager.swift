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
    
    static func getData(url: URL, completion: @escaping (String?) -> Void) {
        let task = session.dataTask(with: url) { (data, responce, error) in
            guard error == nil else {
                print(error.debugDescription)
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
    
    static func getData2(url: URL) {
        let task = session.dataTask(with: url) { (data, responce, error) in
            guard error == nil else {
                print(error.debugDescription)
                return
            }
            guard let httpResp = responce as? HTTPURLResponse, httpResp.statusCode == 200 else { return }
            print(httpResp.statusCode)
            //print(httpResp.allHeaderFields as! [String: Any])
            if let data = data {
                print(data)
            }
            
        }
        task.resume()
    }

}


enum AppConfiguration {
    case first(String)
    case second(String)
    case third(String)
}
