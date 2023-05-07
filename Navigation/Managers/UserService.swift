//
//  UserService.swift
//  Navigation
//
//  Created by Dima Gorbachev on 07.05.2023.
//  Copyright © 2023 Artem Novichkov. All rights reserved.
//

import Foundation

final class UserService {
    let loginInspector: LoginInspector
    let user: RealmUser?
    
    init() {
        loginInspector = LoginInspector()
        user = loginInspector.readUser()
        print("from UserService")
        print(user?.login)
    }
}
