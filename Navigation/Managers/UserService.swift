//
//  UserService.swift
//  Navigation
//
//  Created by Dima Gorbachev on 07.05.2023.
//  Copyright © 2023 Artem Novichkov. All rights reserved.
//

import Foundation

final class UserService {
    
    let user: User?
    
    init() {
        let realmManager = RealmManager()
        user = realmManager.getUser()
    }
}
