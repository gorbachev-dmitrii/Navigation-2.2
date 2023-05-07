//
//  ProfileViewModel.swift
//  Navigation
//
//  Created by Dima Gorbachev on 04.09.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class ProfileViewModel {
    
    var coordinator: LoginCoordinator?
    var userService: UserService_old?
    var login: String?
    
    var onShowNext: (() -> Void)?
    
    lazy var onTapShowNextModule: () -> Void = { [weak self] in
        self?.onShowNext?()
    }
    
    func createUser() -> User_old {
        return (userService?.getUser(username: login!))!
    }
}
