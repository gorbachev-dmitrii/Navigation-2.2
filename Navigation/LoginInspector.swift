//
//  LoginInspector.swift
//  Navigation
//
//  Created by Dima Gorbachev on 29.06.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation
import Firebase

class LoginInspector: LoginViewControllerDelegate {
    
    func checkInputData(login: String, password: String) -> String {
        let result = LoginChecker.shared.check(log: login, pass: password)
        return result
    }
    
//    func createUser {
//        Auth.auth().createUser(withEmail: login, password: password) { authResult, error in
//
//            guard let user = authResult?.user, error == nil else {
//                return
//            }
//            print("\(user.email!) created")
//        }
//    }
    
    
}
