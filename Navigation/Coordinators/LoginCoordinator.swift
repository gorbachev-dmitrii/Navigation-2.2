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
    private var login: String = ""
    private var userService: UserService?
    private var controllerFactory: ControllerFactory
    private let loginFactory = MyLoginFactory()
    
    init(navigation: UINavigationController, factory: ControllerFactory) {
        self.navigationController = navigation
        self.controllerFactory = factory
    }
    
    func startNew() {
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
    
    func toSignInVC() {
        let signInVC = SignInViewController()
        signInVC.inspectorDelegate = LoginInspector()
        navigationController.pushViewController(signInVC, animated: true)
        signInVC.onShowNext = {
            self.toProfile()
        }
    }
    
    func toSignUpVC() {
        let signUpVC = SignUpViewController()
        navigationController.pushViewController(signUpVC, animated: true)
        signUpVC.onShowNext = {
            print("coord have got msg from signup")
            //self.toProfile()
        }
    }
    
    func toProfile() {
        let profileModule = controllerFactory.makeProfile()
        profileModule.viewModel.login = login
        profileModule.viewModel.userService = userService
        profileModule.viewModel.onShowNext = { [weak self] in

        }
        navigationController.pushViewController(profileModule.controller, animated: true)
    }
}



