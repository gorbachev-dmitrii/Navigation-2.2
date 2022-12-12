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
    let tabBarController: TabBarController
    private let model = MyModel()
    private let factory = ControllerFactory()
    
    init() {
        tabBarController = TabBarController()
        let feed = configureFeed()
        let login = configureLogin()
        let favorites = configureFavorites()
        feed.start()
        
        let realm = try? Realm()
        let result : [RealmUser] = realm?.objects(AuthModel.self).compactMap {
            guard let email = $0.email, let password = $0.password else { return nil }
            return RealmUser(email: email, password: password)
        } ?? []
        
        if result.count != 0 {
            login.toProfile()
        } else {
            login.start()
        }
        
        favorites.start()
        
        tabBarController.viewControllers = [feed.navigationController, login.navigationController,  favorites.navigationController]
        coordinators.append(feed)
        coordinators.append(login)
        coordinators.append(favorites)
    }
    
    private func configureFeed() -> FeedCoordinator {
        
        let navigationController = UINavigationController()
        navigationController.tabBarItem = UITabBarItem(
            title: "tabBarFeed".localized,
            image: UIImage(systemName: "house.fill"),
            selectedImage: nil)
        let feedCoordinator = FeedCoordinator(navigation: navigationController, model: model)
        return feedCoordinator
    }
    
    private func configureLogin() -> LoginCoordinator {

        let navigationController = UINavigationController()
        navigationController.tabBarItem = UITabBarItem(
            title: "tabBarProfile".localized,
            image: UIImage(systemName: "person.fill"),
            selectedImage: nil)
        let loginCoordinator = LoginCoordinator(navigation: navigationController, factory: factory)
        return loginCoordinator
    }
    
    private func configureFavorites() -> FavoritesCoordinator {
        let navigationController = UINavigationController()
        navigationController.tabBarItem = UITabBarItem(
            title: "tabBarFavorite".localized,
            image: UIImage(systemName: "list.star"),
            selectedImage: nil)
        let favCoordinator = FavoritesCoordinator(navigation: navigationController)
        return favCoordinator
    }
}
