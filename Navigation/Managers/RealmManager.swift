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
    
    func getUser() -> User? {
        return realm.objects(User.self).first
    }
    
    func checkUser(login: String, password: String) -> User? {
        let user = getUser()
        if user?.login == login && user?.password == password {
            return user
        } else {
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
    func getAllPosts() -> [Post] {
        return Array(realm.objects(Post.self))
    }
    
    func getUserPosts(user: User) -> [Post] {
        let posts = realm.objects(Post.self).where {
            $0.author == user.login
        }
        return Array(posts)
    }
    
//    func getFavoritesPosts() -> [Post] {
//
//    }
    
    func updatePost(post: Post, isSaved: Bool?) {
        print(post.isSaved)
        if isSaved != nil {
            print("prishlo iz controllera go sohranyat'")
            try! realm.write {
                post.isSaved.toggle()
            }
            print(post.isSaved)
        }
//        if let likes = likes {
//            try! realm.write {
//                post.likes += 1
//            }
//        }
    }
    
    // только для теста
    func saveTestPosts() {
        let post1 = Post(author: "Netflix", content: "Netflix скоро заговорит по-русски! Будет доступен на русском языке!", image: "netflix", likes: 10, isSaved: false)
        let post2 = Post(author: "Mobile review", content: "Музыкальный стриминговый сервис Spotify официально пришел в Россию", image: "spotify", likes: 20, isSaved: false)
        let post3 = Post(author: "test", content: "Недавно Epic Games включила S.T.A.L.K.E.R. 2 в список готовящихся игр, которые создаются на базе движка компании — Unreal Engine 4. Слухи об этом ходили с самого анонса, однако до текущего момента определённости в вопросе не было.", image: "stalker", likes: 30, isSaved: false)
        try! realm.write {
            realm.add(post1)
            realm.add(post2)
            realm.add(post3)
        }
    }
    
    func removeTestPosts() {
        try! realm.write {
            realm.delete(getAllPosts())
        }
    }
    
    
    
}

extension Results {
    func toArray() -> [Element] {
      return compactMap {
        $0
      }
    }
 }
