//
//  User.swift
//  Navigation
//
//  Created by Dima Gorbachev on 11.06.2023.
//  Copyright © 2023 Artem Novichkov. All rights reserved.
//

import Foundation
import RealmSwift

class User: Object {
    @Persisted var login: String = ""
    @Persisted var password: String = ""
    
    convenience init(login: String, password: String) {
        self.init()
        self.login = login
        self.password = password
    }
}
