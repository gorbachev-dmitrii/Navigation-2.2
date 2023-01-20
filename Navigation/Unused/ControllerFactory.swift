//
//  ControllerFactory.swift
//  Navigation
//
//  Created by Dima Gorbachev on 04.09.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

//protocol ControllerFactory {
//    func makeProfile() -> (viewModel: ProfilelViewModel, controller: ProfileViewController)
//
//}
//
struct ControllerFactory {

//    func makeProfile() -> (viewModel: ProfileViewModel, controller: ProfileViewController) {
//        let viewModel = ProfileViewModel()
//        let profileVC = ProfileViewController(viewModel: viewModel)
//        return (viewModel, profileVC)
//    }
    
    func makePhotos() -> PhotosViewController {
        let vc = PhotosViewController()
        return vc
    }
}
