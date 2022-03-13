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
        signIn(log: login, pass: password)
        return result
    }
    
    func createUser(log: String, pass: String ) {
        Auth.auth().createUser(withEmail: log, password: pass) { authResult, error in
            if let user = authResult?.user, error == nil {
                print("\(user.email!) created")
            } else {
                print(error.debugDescription)
                return
            }
        }
    }
    
    func signIn(log: String, pass: String) {
        Auth.auth().signIn(withEmail: log, password: pass) { authResult, error in
            if authResult?.user == nil {
                print("fail, try to create user")
                self.createUser(log: log, pass: pass)
            } else {
                print("success")
            }
            print(authResult.debugDescription)
            print("-------------")
            print(error.debugDescription)
        }
    }
}
