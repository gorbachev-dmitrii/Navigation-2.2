//
//  AppCoordinator.swift
//  Navigation
//
//  Created by Dima Gorbachev on 02.05.2023.
//  Copyright © 2023 Artem Novichkov. All rights reserved.
//

import UIKit

protocol Coordinator: AnyObject {
    var coordinators: [Coordinator] { get set }
}

// AppCoordinator управляет Flow - запуск координатора авторизация/регистрация или основного координатора приложения

final class AppCoordinator {
    let navigation: UINavigationController
    let userService: UserService
    
    init() {
        navigation = UINavigationController()
        userService = UserService()
    }
    // Определение Flow на основании того, есть юзер в БД или нет
    func start() {
        checkAuthState() ? configureMainFlow() : configureAuthFlow()
    }
    
    private func configureAuthFlow() {
        let authCoordinator = AuthCoordinator(navigation: navigation)
        authCoordinator.start()
    }
    
    private func configureMainFlow() {
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


