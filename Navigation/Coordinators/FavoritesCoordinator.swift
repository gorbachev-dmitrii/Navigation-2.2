//
//  FavoritesCoordinator.swift
//  Navigation
//
//  Created by Dima Gorbachev on 29.08.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import UIKit

final class FavoritesCoordinator: Coordinator {
    let navigationController: UINavigationController
    var coordinators: [Coordinator] = []
    
    init(navigation: UINavigationController) {
        self.navigationController = navigation
    }
    
    func start() {
        let controller = PostViewController()
        navigationController.pushViewController(controller, animated: true)
    }
}
