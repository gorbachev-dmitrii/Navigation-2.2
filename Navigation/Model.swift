//
//  Model.swift
//  Navigation
//
//  Created by Dima Gorbachev on 08.07.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation

class MyModel {
    
    var response: (() -> Void)?
    
    var password: String = "Qwer"
    
    func check(word: String) -> Bool {
        return word == password
    }
}
