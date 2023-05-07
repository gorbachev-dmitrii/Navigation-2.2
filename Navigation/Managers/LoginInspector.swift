//
//  LoginInspector.swift
//  Navigation
//
//  Created by Dima Gorbachev on 29.06.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation
import RealmSwift

// MARK: LoginDelegate
protocol LoginDelegate: AnyObject {
    func authorizeUser(login: String, password: String) -> RealmUser?
    func registerUser(login: String, password: String)
    func getUser() -> RealmUser?
}

final class LoginInspector: LoginDelegate {
    
    // MARK: Интерфейс класса
    
    func authorizeUser(login: String, password: String) -> RealmUser? {
        return checkUserData(login: login, password: password)
    }
    
    func registerUser(login: String, password: String) {
        checkIfExists(login: login, password: password)
    }
    
    func getUser() -> RealmUser? {
        return readUser()
    }
    
    // MARK: Realm functions
    
    private func checkUserData(login: String, password: String) -> RealmUser? {
        let realm = try? Realm()
        guard let users = realm?.objects(RealmUserModel.self) else {return nil}
        if users.contains(where: { $0.login == login && $0.password == password }) {
            return RealmUser(login: login, password: password)
        } else {
            return nil
        }
    }
    
    private func checkIfExists(login: String, password: String) {
        let realm = try? Realm()
        guard let users = realm?.objects(RealmUserModel.self) else {return}
        if !users.contains(where: { $0.login == login && $0.password == password }) {
            saveUserToRealm(login: login, password: password)
        } else {
            print("Такой пользователь уже зарегистрирован")
        }
    }
    
    private func saveUserToRealm(login: String, password: String) {
        let realm = try? Realm()
        let realmUserObject = RealmUserModel()
        realmUserObject.login = login
        realmUserObject.password = password
        do {
            realm?.beginWrite()
            realm?.add(realmUserObject)
            try realm?.commitWrite()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func readUser() -> RealmUser? {
        let realm = try? Realm()
        let users: [RealmUser] = realm?.objects(RealmUserModel.self).compactMap {
            guard let login = $0.login, let password = $0.password else { return nil }
            return RealmUser(login: login, password: password)
        } ?? []
        let user = !users.isEmpty ? users[0] : nil
        return user
    }
}
