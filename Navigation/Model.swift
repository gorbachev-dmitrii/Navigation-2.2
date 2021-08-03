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
    
    private static var password: String = "Qwer"
    
    var checker: ((_ word: String) -> Bool) = { word in
        let result = word == password
        return result
    }
    
//    func check(word: String, closure: @escaping () -> Void) -> Bool {
//        response = closure
//        return word == password
//    }
}
