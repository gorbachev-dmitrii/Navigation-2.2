//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Dima Gorbachev on 16.01.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
 
    let profileHeader = ProfileHeaderView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        view.addSubview(profileHeader)
        view.addSubview(profileHeader.userNameLabel)
        view.addSubview(profileHeader.showStatusButton)
        view.addSubview(profileHeader.userImage)
        view.addSubview(profileHeader.statusInput)
        view.addSubview(profileHeader.statusLabel)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        profileHeader.frame = view.frame
        
        profileHeader.userImage.frame = CGRect(
            x: view.frame.origin.x + 16,
            y: view.safeAreaInsets.top + 16,
            width: 125,
            height: 125)
        profileHeader.userImage.layer.cornerRadius = profileHeader.userImage.frame.height / 2

        profileHeader.userNameLabel.frame = CGRect(
            x: 0,
            y: view.safeAreaInsets.top + 27,
            width: 50,
            height: 50)
        profileHeader.userNameLabel.center.x = view.center.x
        profileHeader.userNameLabel.sizeToFit()
        
        profileHeader.showStatusButton.frame = CGRect(
            x: view.frame.origin.x + 16,
            y: profileHeader.userImage.frame.maxY + 16,
            width: view.frame.width - 32,
            height: 50)
        
        profileHeader.statusInput.frame = CGRect(
            x: profileHeader.userNameLabel.frame.minX,
            y: profileHeader.showStatusButton.frame.minY - 34 - 40,
            width: 40,
            height: 40)
        profileHeader.statusInput.sizeToFit()
        
        profileHeader.statusLabel.frame = CGRect(
            x: profileHeader.statusInput.frame.minX,
            y: profileHeader.statusInput.frame.maxY + 5,
            width: profileHeader.statusInput.frame.width,
            height: 40)
    }
}
