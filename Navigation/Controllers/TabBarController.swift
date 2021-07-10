//
//  TabBarController.swift
//  Navigation
//
//  Created by Dima Gorbachev on 10.07.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let feedController = FeedViewController()
        let navigationFirst = UINavigationController(rootViewController: feedController)
        navigationFirst.tabBarItem = UITabBarItem(
            title: "Feed",
            image: UIImage(systemName: "house.fill"),
            selectedImage: nil)
        
        let loginController = LogInViewController()
        let navigationSecond = UINavigationController(rootViewController: loginController)
        navigationSecond.tabBarItem = UITabBarItem(
            title: "Profile",
            image: UIImage(systemName: "person.fill"),
            selectedImage: nil)

        viewControllers = [navigationFirst, navigationSecond]
    }
}
