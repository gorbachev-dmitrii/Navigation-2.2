//
//  CurrentUserService.swift
//  Navigation
//
//  Created by Dima Gorbachev on 26.06.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation

protocol UserService {
    func getUser(username: String) -> User
}

class CurrentUserService: UserService {
    var currentUser = User(name: "user", avatar: "cat.jpg", status: "Waiting for something")
    
    func getUser(username: String) -> User {
        if username == currentUser.name {
            return currentUser
        } else {
            return User(name: "error", avatar: "error.jpg", status: "error")
        }
    }
}

class TestUserService: UserService {
    var testUser = User(name: "test", avatar: "userImage.png", status: "test status")
    
    func getUser(username: String) -> User {
        if username == testUser.name {
            return testUser
        } else {
            return User(name: "error", avatar: "error.jpg", status: "error")
        }
    }
}
