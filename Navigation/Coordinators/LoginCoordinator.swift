//
//  LoginCoordinator.swift
//  Navigation
//
//  Created by Dima Gorbachev on 28.08.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

final class LoginCoordinator: Coordinator {
    let navigationController: UINavigationController
    var coordinators: [Coordinator] = []
    private var login: String?
    
    init(navigation: UINavigationController) {
        self.navigationController = navigation
    }
    
    func start() {
        let loginController = LogInViewController()
        navigationController.pushViewController(loginController, animated: true)
        loginController.onShowNext = { [weak self] in
            self?.login = $0
            self?.goNext()
        }
    }
    
    private func goNext() {
        let testUser = TestUserService()
        let vc = ProfileViewController(userService: testUser, username: login!)
        navigationController.pushViewController(vc, animated: true)
    }
}
