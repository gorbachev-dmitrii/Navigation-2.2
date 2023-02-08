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
    let tabBarController: UITabBarController
    private let model = MyModel()
    let inspector = LoginInspector()
    
    init() {
        tabBarController = UITabBarController()
        let loginCoordinator = configureLogin(tabBar: tabBarController)
        let favoritesCoordinator = configureFavorites()
        let profileCoordinator = configureProfile()
        favoritesCoordinator.start()
        profileCoordinator.start()
        loginCoordinator.start()
        
        tabBarController.viewControllers = [loginCoordinator.navigationController, profileCoordinator.navigationController, favoritesCoordinator.navigationController]
        tabBarController.tabBar.isHidden = true
        
        coordinators.append(profileCoordinator)
        coordinators.append(loginCoordinator)
        coordinators.append(favoritesCoordinator)
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
    
    private func configureLogin(tabBar: UITabBarController) -> LoginCoordinator {
        let navigationController = UINavigationController()
        navigationController.tabBarItem = UITabBarItem(
            title: "tabBarFeed".localized,
            image: UIImage(systemName: "house.fill"),
            selectedImage: nil)
        let loginCoordinator = LoginCoordinator(navigation: navigationController, tabBar: tabBar)
        return loginCoordinator
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
    
    private func check() -> Bool {
        // true = юзер есть, не авторизовываем его
        return true
    }
}
