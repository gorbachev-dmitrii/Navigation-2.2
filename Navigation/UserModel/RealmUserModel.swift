//
//  RealmUserModel.swift
//  Navigation
//
//  Created by Dima Gorbachev on 11.01.2023.
//  Copyright © 2023 Artem Novichkov. All rights reserved.
//

import Foundation
import RealmSwift

class RealmUserModel: Object {
    
    @objc dynamic var login: String?
    @objc dynamic var password: String?
    @objc dynamic var status: String?
//    @objc dynamic var name: String?
//    @objc dynamic var avatar: String?

}

final class RealmUser {
    let login: String
    let password: String
    var status: String?
//    var name: String?
//    var avatar: String?
    
    init(login: String, password: String) {
        self.login = login
        self.password = password
    }
}
