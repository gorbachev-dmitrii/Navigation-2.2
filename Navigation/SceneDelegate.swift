//
//  SceneDelegate.swift
//  Navigation
//
//  Created by Artem Novichkov on 12.09.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private let loginFactory = MyLoginFactory()
    private let myModel = MyModel()
    private var appConfig: AppConfiguration?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        
        let tabBarController = TabBarController()
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        if let tabController = window?.rootViewController as? UITabBarController,
           let loginNavigation = tabController.viewControllers?.last as? UINavigationController,
           let loginController = loginNavigation.viewControllers.first as? LogInViewController,
           let feedNavigation = tabController.viewControllers?.first as? UINavigationController,
           let feedController = feedNavigation.viewControllers.first as? FeedViewController   {
            loginController.inspectorDelegate = loginFactory.createInspector()
            feedController.model = myModel
                }
        
        //NetworkManager.fetchData(config: randomConfig())
        
    }

    private func randomConfig() -> AppConfiguration {
        let randomInt = Int.random(in: 1...3)
        switch randomInt {
        case 1: appConfig = .first(URL(string: "https://swapi.dev/api/people/8")!)
        case 2: appConfig = .second(URL(string: "https://swapi.dev/api/starships/3")!)
        case 3: appConfig = .third(URL(string: "https://swapi.dev/api/planets/5")!)
        default:
            print("not found")
        }
        return appConfig!
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

