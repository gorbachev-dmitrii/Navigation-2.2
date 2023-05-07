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
    
    init() {
        navigation = UINavigationController()
    }
    
    func start() {
        // тут логика запуска либо логин координатора, либо главного, в зависимости от того, есть ли юзер в БД
        // обращение к LoginInspector?
        configureMain()
    }
//
//    private func configureAuth() {
//        let authCoordinator = LoginCoordinator(navigationController: navigation)
//        authCoordinator.start()
//    }
    
    private func configureMain() {
        let mainCoordinator = MainCoordinator(navigationController: navigation)
        mainCoordinator.navigationController.navigationBar.isHidden = true
        mainCoordinator.start()
    }
}


