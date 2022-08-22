//
//  User.swift
//  Navigation
//
//  Created by Dima Gorbachev on 26.06.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation

class User {
    var name: String
    var avatar: String
    var status: String
    
    init(name: String, avatar: String, status: String) {
        self.name = name
        self.avatar = avatar
        self.status = status
    }
}


