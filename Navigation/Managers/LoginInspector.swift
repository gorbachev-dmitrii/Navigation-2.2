//
//  LoginInspector.swift
//  Navigation
//
//  Created by Dima Gorbachev on 29.06.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation
import RealmSwift

final class LoginInspector: LoginDelegate {
    
    func checkСredentials(login: String, password: String) -> RealmUser? {
        return checkUserData(login: login, password: password)
    }
    
    
    
    func checkIfExists(login: String, password: String) {
        let realm = try? Realm()
        guard let users = realm?.objects(RealmUserModel.self) else {return}
        if users.contains(where: { $0.login == login && $0.password == password }) {
            print("Такой пользователь уже зарегистрирован")
        } else {
            print("Нужно сохранить в БД")
            saveUserToRealm(login: login, password: password)
        }
    }
    
    // MARK: Realm
    
    private func checkUserData(login: String, password: String) -> RealmUser? {
        let realm = try? Realm()
        guard let users = realm?.objects(RealmUserModel.self) else {return nil}
        if users.contains(where: { $0.login == login && $0.password == password }) {
            print("Данные верны")
            return RealmUser(login: login, password: password)
        } else {
            print("Неверный пароль")
            return nil
        }
    }
    // registartion
    private func checkLoginIfExists(login: String, password: String) {
        let realm = try? Realm()
        guard let users = realm?.objects(RealmUserModel.self) else {return}
        if users.contains(where: { $0.login == login }) {
            print("Пользователь с таким логином уже зарегистрирован")
        } else {
            print("Гоу сохранять в БД")
            saveUserToRealm(login: login, password: password)
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
    
    func readUser() -> RealmUser? {
        let realm = try? Realm()
        let users: [RealmUser] = realm?.objects(RealmUserModel.self).compactMap {
            guard let login = $0.login, let password = $0.password else { return nil }
            return RealmUser(login: login, password: password)
        } ?? []
        print("Available Users are  : \(users)")
        
        if !users.isEmpty {
            return users[0]
        } else {
            return nil
        }
    }
    
    // unused
    private func compareRealmUsers(email: String, password: String) -> String {
        let lastUser = readRealmUser()
        let user = RealmUser_old(email: email, password: password)
        if user.email == lastUser?.email, user.password == lastUser?.password {
            print("Logining Current User")
            return "Success"
        } else {
            saveRealmUser(login: email, password: password)
            return "Fail"
        }
    }
    
    func checkInputData(login: String, password: String) -> String {
        let result = compareRealmUsers(email: login, password: password)
        return result
    }
    
    func readRealmUser() -> RealmUser_old? {
        let realm = try? Realm()
        let result : [RealmUser_old] = realm?.objects(AuthModel.self).compactMap {
            guard let email = $0.email, let password = $0.password else { return nil }
            return RealmUser_old(email: email, password: password)
        } ?? []
        print("Available Users are  : \(result)")
        
        if result.count != 0 {
            return result[0]
        } else {
            return nil
        }
    }
    
    private func saveRealmUser(login: String, password: String) {
        let realm = try? Realm()
        let realmUserObject = AuthModel()
        realmUserObject.email = login
        realmUserObject.password = password
        do {
            realm?.beginWrite()
            realm?.add(realmUserObject)
            try realm?.commitWrite()
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
