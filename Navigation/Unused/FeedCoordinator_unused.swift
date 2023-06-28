////
////  FeedCoordinator.swift
////  Navigation
////
////  Created by Dima Gorbachev on 28.08.2021.
////  Copyright © 2021 Artem Novichkov. All rights reserved.
////
//
//import UIKit
//import StorageService
//
//final class FeedCoordinator_unused: Coordinator {
//
//    let post: Post = Post(title: "Пост")
//    var coordinators: [Coordinator] = []
//    let navigationController: UINavigationController
//    private let model: MyModel
//
//    init(navigation: UINavigationController, model: MyModel) {
//        self.navigationController = navigation
//        self.model = model
//    }
//    
//    func start() {
//        let feedController = FeedViewController()
//        navigationController.pushViewController(feedController, animated: true)
//        feedController.onShowNext = { [weak self] in
//            self?.goNext()
//        }
//    }
//
//    private func goNext() {
//        let vc = FavoritesViewController()
//        navigationController.pushViewController(vc, animated: true)
//        vc.post = post
//    }
//}
