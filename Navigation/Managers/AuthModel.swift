//
//  AuthModel.swift
//  Navigation
//
//  Created by Dima Gorbachev on 12.08.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import Foundation
import RealmSwift

class AuthModel: Object {
    
    @objc dynamic var email: String?
    @objc dynamic var password: String?
    
}

final class RealmUser {
    let email: String
    let password: String
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
}
