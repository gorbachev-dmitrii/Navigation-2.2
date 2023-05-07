//
//  AppCoordinator.swift
//  Navigation
//
//  Created by Dima Gorbachev on 02.05.2023.
//  Copyright © 2023 Artem Novichkov. All rights reserved.
//

import UIKit


// управляет Flow - запуск координатора авторизация/регистрация и основного координатора приложения

final class AppCoordinator {
    let navigation: UINavigationController
    let userService: UserService
    
    init() {
        navigation = UINavigationController()
        userService = UserService()
    }
    
    func start() {
        checkAuthState() ? configureMain() : configureAuth()
    }
    //
    private func configureAuth() {
        let authCoordinator = LoginCoordinator(navigation: navigation)
        authCoordinator.start()
    }
    
    private func configureMain() {
        let mainCoordinator = MainCoordinator(navigationController: navigation, userService: userService)
        mainCoordinator.navigationController.navigationBar.isHidden = true
        mainCoordinator.start()
    }
    
    private func checkAuthState() -> Bool {
        if userService.user != nil {
            return true
        } else {
            return false
        }
    }
}


