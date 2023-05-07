//
//  CurrentUserService.swift
//  Navigation
//
//  Created by Dima Gorbachev on 26.06.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation

protocol UserService_old {
    func getUser(username: String) -> User_old
}

class CurrentUserService: UserService_old {
    var currentUser = User_old(name: "user", avatar: "cat.jpg", status: "Waiting for something")
    
    func getUser(username: String) -> User_old {
        if username == currentUser.name {
            return currentUser
        } else {
            return User_old(name: "error", avatar: "error.jpg", status: "error")
        }
    }
}

class TestUserService: UserService_old {
    var testUser = User_old(name: "test", avatar: "userImage.png", status: "test status")
    
    func getUser(username: String) -> User_old {
        if username == testUser.name {
            return testUser
        } else {
            return User_old(name: "error", avatar: "error.jpg", status: "error")
        }
    }
}
