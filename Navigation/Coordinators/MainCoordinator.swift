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
    //private let factory = ControllerFactory()
    
    init() {
        tabBarController = UITabBarController()
        let loginCoordinator = configureLogin(tb: tabBarController)
        let favoritesCoordinator = configureFavorites()
        let profileCoordinator = configureProfile()
        favoritesCoordinator.start()
        profileCoordinator.start()
        
        tabBarController.viewControllers = [loginCoordinator.navigationController, profileCoordinator.navigationController, favoritesCoordinator.navigationController]
        
        if check() {
            loginCoordinator.toFeed()
        } else {
            tabBarController.tabBar.isHidden = true
            loginCoordinator.start()
            
        }
        
//        let realm = try? Realm()
//        let result : [RealmUser] = realm?.objects(RealmUserModel.self).compactMap {
//            guard let login = $0.login, let password = $0.password else { return nil }
//            return RealmUser(login: login, password: password)
//        } ?? []
//        if result.count != 0 {
//            loginCoordinator.toProfile()
//        } else {
//            loginCoordinator.startNew()
//        }

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
    
    private func configureLogin(tb: UITabBarController) -> LoginCoordinator {
        let navigationController = UINavigationController()
        navigationController.tabBarItem = UITabBarItem(
            title: "tabBarFeed".localized,
            image: UIImage(systemName: "house.fill"),
            selectedImage: nil)
        let loginCoordinator = LoginCoordinator(navigation: navigationController, tb: tb)
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
        return false
    }
}
