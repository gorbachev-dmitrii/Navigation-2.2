//
//  FeedCoordinator.swift
//  Navigation
//
//  Created by Dima Gorbachev on 28.08.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

final class FeedCoordinator {
    
    let navigationController: UINavigationController
    private let model: MyModel
    
    init(navigation: UINavigationController, model: MyModel) {
        self.navigationController = navigation
        self.model = model
    }
    
    func start() {
        let feedController = FeedViewController(model: model)
        navigationController.pushViewController(feedController, animated: true)
    }
}
