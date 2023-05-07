//
//  MainCoordinator.swift
//  Navigation
//
//  Created by Dima Gorbachev on 25.08.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit
import RealmSwift

protocol Coordinator: AnyObject {
    var coordinators: [Coordinator] { get set }
}

class MainCoordinator: Coordinator {
    var coordinators: [Coordinator] = []
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let tabBarController = UITabBarController()
        navigationController.pushViewController(tabBarController, animated: true)
        let feedCoordinator = configureFeed()
        let profileCoordinator = configureProfile()
        let favoritesCoordinator = configureFavorites()
        feedCoordinator.start()
        profileCoordinator.start()
        favoritesCoordinator.start()
        tabBarController.viewControllers = [feedCoordinator.navigationController , profileCoordinator.navigationController, favoritesCoordinator.navigationController]
        coordinators.append(feedCoordinator)
        coordinators.append(profileCoordinator)
        coordinators.append(favoritesCoordinator)
    }
    
    private func configureFeed() -> FeedCoordinator {
        let navigationController = UINavigationController()
        navigationController.tabBarItem = UITabBarItem(
            title: "tabBarFeed".localized,
            image: UIImage(systemName: "house.fill"),
            selectedImage: nil)
        let feedCoordinator = FeedCoordinator(navigation: navigationController)
        return feedCoordinator
    }
    
    private func configureProfile() -> ProfileCoordinator {
        let navigationController = UINavigationController()
        navigationController.tabBarItem = UITabBarItem(
            title: "tabBarProfile".localized,
            image: UIImage(systemName: "person.crop.circle"),
            selectedImage: nil)
        let profileCoordinator = ProfileCoordinator(navigation: navigationController)
        return profileCoordinator
    }
    
    private func configureFavorites() -> FavoritesCoordinator {
        let navigationController = UINavigationController()
        navigationController.tabBarItem = UITabBarItem(
            title: "tabBarFavorite".localized,
            image: UIImage(systemName: "heart"),
            selectedImage: nil)
        let favCoordinator = FavoritesCoordinator(navigation: navigationController)
        return favCoordinator
    }
}
