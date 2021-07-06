//
//  LogInView.swift
//  Navigation
//
//  Created by Dima Gorbachev on 30.01.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class LogInView: UIView {
    
    let logoView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let loginInput: UITextField = {
        let input = UITextField()
        input.placeholder = "Email or phone"
        input.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return input
    }()
    
    let passwordInput: UITextField = {
        let input = UITextField()
        input.placeholder = "Password"
        input.isSecureTextEntry = true
        input.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        return input
    }()
    
    private lazy var logInButton: UIButton = {
//        let button = MyButton(title: "Login", titleColor: .white) {
//            self.loginTapped()
//        }
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "blue_pixel"), for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10
        button.setTitle("Log In", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
//    func loginTapped() {
//        #if DEBUG
//        let testUser = TestUserService()
//        let vc = ProfileViewController(userService: testUser, username: loginInput.text!)
//        navigationController?.pushViewController(vc, animated: true)
//        #elseif RELEASE
//        let currentUser = CurrentUserService()
//        let vc = ProfileViewController(userService: currentUser, username: loginInput.text!)
//        navigationController?.pushViewController(vc, animated: true)
//        #endif
//    }
    
    func setupTextField(textFields: [UITextField]) {
        for textField in textFields {
            textField.layer.borderColor = UIColor.lightGray.cgColor
            textField.layer.borderWidth = 0.5
            textField.layer.cornerRadius = 10
            textField.textColor = .black
            textField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
            textField.tintColor = .blue
            textField.autocapitalizationType = .none
            textField.backgroundColor = .systemGray6
            textField.translatesAutoresizingMaskIntoConstraints = false
        }
    }
}
