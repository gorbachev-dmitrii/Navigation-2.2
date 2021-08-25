//
//  MainCoordinator.swift
//  Navigation
//
//  Created by Dima Gorbachev on 25.08.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class MainCoordinator {
    let tabBarController: TabBarController
    let model = MyModel()
    
    init() {
        tabBarController = TabBarController()
        let first = configureFeed()
        let second = configureLogin()
        tabBarController.viewControllers = [first, second]
    }
    
    private func configureFeed() -> UINavigationController {
        let feedController = FeedViewController(model: model)
        let navigationFirst = UINavigationController(rootViewController: feedController)
        navigationFirst.tabBarItem = UITabBarItem(
            title: "Feed",
            image: UIImage(systemName: "house.fill"),
            selectedImage: nil)
        return navigationFirst
    }
    
    private func configureLogin() -> UINavigationController {
        let loginController = LogInViewController()
        let navigationSecond = UINavigationController(rootViewController: loginController)
        navigationSecond.tabBarItem = UITabBarItem(
            title: "Profile",
            image: UIImage(systemName: "person.fill"),
            selectedImage: nil)
        return navigationSecond
    }
}
