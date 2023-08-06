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
        let controller = ProfileViewController(userService: userService)
        navigationController.pushViewController(controller, animated: true)
        controller.onShowPhotos = { 
            self.toPhotos()
        }
        controller.profileHeader.onShowEdit = { [weak self] in
            self?.toEditProfile()
        }
    }
    
    func toEditProfile() {
        let controller = EditViewController(userService: userService)
        navigationController.pushViewController(controller, animated: true)
        controller.onSaveButtonTapped = {
            self.start()
        }
    }
    
    private func toPhotos() {
        let controller = PhotosViewController()
        navigationController.pushViewController(controller, animated: true)
    }
    
}
