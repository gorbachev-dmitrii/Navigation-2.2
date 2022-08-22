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
    
    private let login = "test"
    private let password = "1234"
    
    func check(log: String, pass: String) -> String {
        if log.hash == login.hash && pass.hash == password.hash {
            return "Success"
        } else {
            return "Fail"
        }
    }
}
