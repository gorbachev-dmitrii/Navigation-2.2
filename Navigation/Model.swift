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
    
    var checker: ((_ word: String) -> Bool) = { word in
        let result = word == password
        return result
    }
}
