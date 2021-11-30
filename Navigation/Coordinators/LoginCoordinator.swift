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
//    private var inspector: LoginInspector?
    private let loginFactory = MyLoginFactory()
    
    init(navigation: UINavigationController, factory: ControllerFactory) {
        self.navigationController = navigation
        self.controllerFactory = factory
    }
    
    func start() {
        let loginController = LogInViewController()
        loginController.inspectorDelegate = loginFactory.createInspector()
        navigationController.pushViewController(loginController, animated: true)
        loginController.onShowNext = { [weak self] in
            self?.login = $0
            self?.userService = $1
            self?.toProfile()
        }
    }
    
    private func toProfile() {
        let profileModule = controllerFactory.makeProfile()
        profileModule.viewModel.login = login
        profileModule.viewModel.userService = userService
        profileModule.viewModel.onShowNext = { [weak self] in
            self?.toPhotos()
        }
        navigationController.pushViewController(profileModule.controller, animated: true)
    }
    
    private func toPhotos() {
        let photosController = controllerFactory.makePhotos()
        navigationController.pushViewController(photosController, animated: true)
    }
}
