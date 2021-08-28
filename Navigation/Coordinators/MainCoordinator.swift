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
        let feed = configureFeed()
        let login = configureLogin()
        feed.start()
        login.start()
        tabBarController.viewControllers = [feed.navigationController, login.navigationController]
    }
    
    private func configureFeed() -> FeedCoordinator {
        
        let navigationController = UINavigationController()
        navigationController.tabBarItem = UITabBarItem(
            title: "Feed",
            image: UIImage(systemName: "house.fill"),
            selectedImage: nil)
        let feedCoordinator = FeedCoordinator(navigation: navigationController, model: model)
        return feedCoordinator
    }
    
    private func configureLogin() -> LoginCoordinator {
        
        let navigationController = UINavigationController()
        navigationController.tabBarItem = UITabBarItem(
            title: "Profile",
            image: UIImage(systemName: "person.fill"),
            selectedImage: nil)
        
        let loginCoordinator = LoginCoordinator(navigation: navigationController)
        
        return loginCoordinator
    }
}
