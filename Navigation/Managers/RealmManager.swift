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
            schemaVersion: 4)
        Realm.Configuration.defaultConfiguration = config
        realm = try! Realm()
    }
    // MARK: Users methods
    func createUser(login: String, password: String) {
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
    
    func updateUser(user: User, jobName: String?, fullname: String?) {
        try! realm.write {
            user.fullname = fullname
            user.jobName = jobName
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
    
    func getFavoritePosts() -> [Post] {
//        let favPosts = getAllPosts().filter {
//            $0.isSaved == true
//        }
//        return favPosts
        let favPosts = realm.objects(Post.self).where {
            $0.isSaved == true
        }
        return Array(favPosts)
    }
    
    func updateIsSaved(post: Post) {
        try! realm.write {
            post.isSaved.toggle()
        }
    }
    
    func updateLikes(post: Post) {
        try! realm.write {
            if post.isLiked {
                post.likes -= 1
                post.isLiked.toggle()
            } else {
                post.likes += 1
                post.isLiked.toggle()
            }
        }
    }
    
    // только для теста
    func saveTestPosts() {
        if getAllPosts().count == 0 {
            let post1 = Post(author: "Netflix", content: "Netflix скоро заговорит по-русски! Будет доступен на русском языке!", image: "netflix", likes: 10, isSaved: false, isLiked: false)
            let post2 = Post(author: "Mobile review", content: "Музыкальный стриминговый сервис Spotify официально пришел в Россию", image: "spotify", likes: 20, isSaved: false, isLiked: false)
            let post3 = Post(author: "test", content: "Недавно Epic Games включила S.T.A.L.K.E.R. 2 в список готовящихся игр, которые создаются на базе движка компании — Unreal Engine 4. Слухи об этом ходили с самого анонса, однако до текущего момента определённости в вопросе не было.", image: "stalker", likes: 30, isSaved: false, isLiked: false)
            let post4 = Post(author: "Meduza", content: "Теперь почти официально: Россия на первом месте по числу жертв коронавируса на душу населения. Это результат действий властей летом 2020 года.", image: "corona", likes: 40, isSaved: false, isLiked: false)
            let post5 = Post(author: "Москва24", content: "Часть Парка Горького перекроют в выходные из-за выпускного", image: "graduation", likes: 5, isSaved: false, isLiked: false)
            let post6 = Post(author: "test", content: "Употребление испортившегося молока в качестве некоего подкорма огурцов (и не только их) имеет смысл. В нём содержится большое количество легкоусвояемых соединений кальция — а это и подпитка растений, и профилактика против мучнистой росы", image: "cucumber", likes: 267, isSaved: false, isLiked: false)
            try! realm.write {
                realm.add(post1)
                realm.add(post2)
                realm.add(post3)
                realm.add(post4)
                realm.add(post5)
                realm.add(post6)
            }
        }
    }
    
    func removeTestPosts() {
        try! realm.write {
            realm.delete(getAllPosts())
        }
    }
    
    
    
}

//extension Results {
//    func toArray() -> [Element] {
//      return compactMap {
//        $0
//      }
//    }
// }
