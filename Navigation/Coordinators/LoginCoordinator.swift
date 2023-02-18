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
    let tabBarController: UITabBarController

    init(navigation: UINavigationController, tabBar: UITabBarController) {
        self.navigationController = navigation
        self.tabBarController = tabBar
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
        signInVC.onShowNext = { [weak self] in
            self?.toFeed()
            self?.tabBarController.tabBar.isHidden = false
        }
    }
    
    func toSignUpVC() {
        let signUpVC = SignUpViewController()
        signUpVC.inspectorDelegate = LoginInspector()
        navigationController.pushViewController(signUpVC, animated: true)
        signUpVC.onShowNext = { [weak self] in
            self?.toFeed()
            self?.tabBarController.tabBar.isHidden = false
        }
    }
    
    func toFeed() {
        let feedVC = FeedViewController()
        navigationController.pushViewController(feedVC, animated: true)

    }
}



