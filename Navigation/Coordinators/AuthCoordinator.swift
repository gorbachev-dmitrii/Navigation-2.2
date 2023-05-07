//
//  AuthCoordinator.swift
//  Navigation
//
//  Created by Dima Gorbachev on 28.08.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

final class AuthCoordinator: Coordinator {
    let navigationController: UINavigationController
    var coordinators: [Coordinator] = []
    let userService = UserService()

    init(navigation: UINavigationController) {
        self.navigationController = navigation
    }
    
    func start() {
        let entryController = EntryViewController()
        navigationController.pushViewController(entryController, animated: true)
        entryController.onShowNext = { sender in
            switch sender {
            case "signIn": self.toSignInVC()
            case "signUp": self.toSignUpVC()
            default: break
            }
        }
    }
    
    private func toSignInVC() {
        let signInVC = SignInViewController()
        signInVC.inspectorDelegate = LoginInspector()
        navigationController.pushViewController(signInVC, animated: true)
        signInVC.onShowNext = { [weak self] in
            self?.coordinateToMain()
        }
    }
    
    private func toSignUpVC() {
        let signUpVC = SignUpViewController()
        signUpVC.inspectorDelegate = LoginInspector()
        navigationController.pushViewController(signUpVC, animated: true)
        signUpVC.onShowNext = { [weak self] in
            self?.coordinateToMain()
        }
    }
    
    private func coordinateToMain() {
        let mainCoordinator = MainCoordinator(navigationController: navigationController, userService: userService)
        mainCoordinator.navigationController.navigationBar.isHidden = true
        mainCoordinator.start()
    }
}



