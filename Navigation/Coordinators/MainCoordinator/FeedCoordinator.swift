//
//  FeedCoordinator.swift
//  Navigation
//
//  Created by Dima Gorbachev on 02.05.2023.
//  Copyright © 2023 Artem Novichkov. All rights reserved.
//

import UIKit

final class FeedCoordinator: Coordinator {
    var coordinators: [Coordinator] = []
    let navigationController: UINavigationController

    init(navigation: UINavigationController) {
        self.navigationController = navigation
    }
    
    func start() {
        let controller = FeedViewController()
        navigationController.pushViewController(controller, animated: true)
    }
}
