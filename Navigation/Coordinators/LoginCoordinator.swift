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
    private var controllerFactory: ControllerFactory?
    private let loginFactory = MyLoginFactory()
    let tabBarController: UITabBarController

    init(navigation: UINavigationController, tb: UITabBarController) {
        self.navigationController = navigation
        self.tabBarController = tb
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
    
    func toSignInVC() {
        let signInVC = SignInViewController()
        signInVC.inspectorDelegate = LoginInspector()
        navigationController.pushViewController(signInVC, animated: true)
        signInVC.onShowNext = { [self] user in
            self.toFeed()
            tabBarController.tabBar.isHidden = false
        }
    }
    
    func toSignUpVC() {
        let signUpVC = SignUpViewController()
        signUpVC.inspectorDelegate = LoginInspector()
        navigationController.pushViewController(signUpVC, animated: true)
        signUpVC.onShowNext = {
            print("coord have got msg from signup")
            //self.toProfile()
        }
    }
    
    func toFeed() {
        let feedVC = FeedViewController()
        navigationController.pushViewController(feedVC, animated: true)

    }
    
//    func toProfile() {
//        let profileVC = ProfileViewController()
//        let profileModule = controllerFactory.makeProfile()
//        profileModule.viewModel.login = login
//        profileModule.viewModel.userService = userService
//        profileModule.viewModel.onShowNext = { [weak self] in
//
//        }
//        navigationController.pushViewController(profileVC, animated: true)
//    }
}



