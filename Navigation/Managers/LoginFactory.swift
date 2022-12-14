//
//  LoginFactory.swift
//  Navigation
//
//  Created by Dima Gorbachev on 03.07.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation

protocol LoginFactory {
    func createInspector() -> LoginInspector
}

class MyLoginFactory: LoginFactory {
    
    func createInspector() -> LoginInspector {
        let inspector = LoginInspector()
        return inspector
    }
}
