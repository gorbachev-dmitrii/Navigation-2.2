//
//  Model.swift
//  Navigation
//
//  Created by Dima Gorbachev on 08.07.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation

class MyModel {
    
    private static var password: String = "Qwer"
    
    func checkWord(word: String, completion: @escaping (Bool) -> ()) {
        completion(word == MyModel.password)
    }
    
}
