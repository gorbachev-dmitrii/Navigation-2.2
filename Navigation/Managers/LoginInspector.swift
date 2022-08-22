//
//  LoginInspector.swift
//  Navigation
//
//  Created by Dima Gorbachev on 29.06.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation
import Firebase
import RealmSwift

class LoginInspector: LoginViewControllerDelegate {
    
    func checkInputData(login: String, password: String) -> String {
        let result = compareRealmUsers(email: login, password: password)
        return result
    }
// MARK: Firebase
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
    
// MARK: Realm
    private func saveRealmUser(email: String, password: String) {
        let realm = try? Realm()
        let realmUserObject = AuthModel()
        realmUserObject.email = email
        realmUserObject.password = password
        do {
            realm?.beginWrite()
            realm?.add(realmUserObject)
            try realm?.commitWrite()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func readRealmUser() -> RealmUser? {
        let realm = try? Realm()
        let result : [RealmUser] = realm?.objects(AuthModel.self).compactMap {
            guard let email = $0.email, let password = $0.password else { return nil }
            return RealmUser(email: email, password: password)
        } ?? []
        print("Available Users are  : \(result)")
        
        if result.count != 0 {
            return result[0]
        } else {
            return nil
        }
    }
    
    private func compareRealmUsers(email: String, password: String) -> String {
        let lastUser = readRealmUser()
        let user = RealmUser(email: email, password: password)
        if user.email == lastUser?.email, user.password == lastUser?.password {
            print("Logining Current User")
            return "Success"
        } else {
            saveRealmUser(email: email, password: password)
            return "Fail"
        }
    }
    
}
