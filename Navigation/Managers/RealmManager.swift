//
//  RealmManager.swift
//  Navigation
//
//  Created by Dima Gorbachev on 11.06.2023.
//  Copyright © 2023 Artem Novichkov. All rights reserved.
//

import Foundation
import RealmSwift

final class RealmManager {
    
    var realm: Realm!
    
    init() {
        let config = Realm.Configuration(
            schemaVersion: 2)
        // Use this configuration when opening realms
        Realm.Configuration.defaultConfiguration = config
        realm = try! Realm()
    }
    // MARK: Users methods
    func createUser(login: String, password: String) {
        // тут надо проверить, если ли уже такой юзер в БД
        try! realm.write {
            realm.add(User(login: login, password: password))
        }
    }
    
    func readUser() -> User? {
        return realm.objects(User.self)[0]
    }
    
    func checkUser(login: String, password: String) -> User? {
        let user = readUser()
        if user?.login == login && user?.password == password {
            print("true")
            return user
        } else {
            print("false")
            return nil
        }
    }
    
    func deleteAllUsers() {
        try! realm.write {
            let users = realm.objects(User.self)
            realm.delete(users)
        }
    }
    
    // MARK: Posts methods
    
    func getAllPosts() {
        
    }
    
    func getUserPosts(user: User) {
        
    }
    
    func updatePost() {
        
    }
}
