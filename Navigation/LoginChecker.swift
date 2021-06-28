//
//  LoginChecker.swift
//  Navigation
//
//  Created by Dima Gorbachev on 29.06.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation

class LoginChecker {
    
    static let shared = LoginChecker()
    
    private init() {
        
    }
    
    private let login = "Dima"
    private let password = "123456"
    
    func check(log: String, pass: String) {
        if log == login && pass == password {
            print("Success")
        } else {
            print("Fail")
        }
    }
}
