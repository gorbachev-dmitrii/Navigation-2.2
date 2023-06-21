//
//  ProfileCoordinator.swift
//  Navigation
//
//  Created by Dima Gorbachev on 08.02.2023.
//  Copyright © 2023 Artem Novichkov. All rights reserved.
//

import UIKit

final class ProfileCoordinator: Coordinator {
    var coordinators: [Coordinator] = []
    let navigationController: UINavigationController
    let userService: UserService
    
    init(navigation: UINavigationController, userService: UserService) {
        self.navigationController = navigation
        self.userService = userService
    }
    
    func start() {
        if let user = userService.user {
            let controller = ProfileViewController(user: user)
            navigationController.pushViewController(controller, animated: true)
        }
    }
    
    func toEditProfile() {
        let controller = UIViewController()
        navigationController.pushViewController(controller, animated: true)
    }
    
}
