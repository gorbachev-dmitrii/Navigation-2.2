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
            schemaVersion: 5)
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
    
    func getUserByLogin(username: String) -> User? {
        let users = realm.objects(User.self).where {
            $0.login == username
        }
        return users.first
    }
    
    func checkUser(login: String, password: String) -> User? {
        let user = getUser()
        if user?.login == login && user?.password == password {
            return user
        } else {
            return nil
        }
    }
    
    func getAllUsers() -> [User] {
        return Array(realm.objects(User.self))
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
    
    func updateUserAvatar(user: User, avatar: Data?) {
        try! realm.write {
            user.avatar = avatar
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
    func saveTestUsers() {
        if getAllUsers().count == 1 {
            createUser(login: "netflix", password: "netflix")
            createUser(login: "mobilereview", password: "mobilereview")
            createUser(login: "meduza", password: "meduza")
            createUser(login: "moscow24", password: "moscow24")
        }
    }
    
    func updateTestUsers() {
        updateUser(user: getUserByLogin(username: "netflix")!, jobName: "Стриминговый сервис", fullname: "Netflix Russia")
        updateUser(user: getUserByLogin(username: "mobilereview")!, jobName: "Онлайн СМИ", fullname: "Mobile review")
        updateUser(user: getUserByLogin(username: "meduza")!, jobName: "Онлайн СМИ", fullname: "Медуза")
        updateUser(user: getUserByLogin(username: "moscow24")!, jobName: "Пресс-служба", fullname: "Москва 24")
    }
    
    func saveTestPosts() {
        if getAllPosts().count == 0 {
            let post1 = Post(author: "netflix", content: "Netflix скоро заговорит по-русски! Будет доступен на русском языке!", image: "netflix", likes: 10, isSaved: false, isLiked: false)
            let post2 = Post(author: "mobilereview", content: "Музыкальный стриминговый сервис Spotify официально пришел в Россию", image: "spotify", likes: 20, isSaved: false, isLiked: false)
            let post3 = Post(author: "test", content: "Недавно Epic Games включила S.T.A.L.K.E.R. 2 в список готовящихся игр, которые создаются на базе движка компании — Unreal Engine 4. Слухи об этом ходили с самого анонса, однако до текущего момента определённости в вопросе не было.", image: "stalker", likes: 30, isSaved: false, isLiked: false)
            let post4 = Post(author: "Medmeduzauza", content: "Теперь почти официально: Россия на первом месте по числу жертв коронавируса на душу населения. Это результат действий властей летом 2020 года.", image: "corona", likes: 40, isSaved: false, isLiked: false)
            let post5 = Post(author: "moscow24", content: "Часть Парка Горького перекроют в выходные из-за выпускного", image: "graduation", likes: 5, isSaved: false, isLiked: false)
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
