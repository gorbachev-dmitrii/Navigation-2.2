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

    init(navigation: UINavigationController) {
        self.navigationController = navigation
    }
    
    func start() {
        let controller = ProfileViewController()
        navigationController.pushViewController(controller, animated: true)
    }
    
}
