//
//  LogInViewController.swift
//  Navigation
//
//  Created by Dima Gorbachev on 28.01.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {
    
    let logInView = LogInView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
        logInView.frame = view.frame
        logInView.setupTextField(textFields: [logInView.loginInput, logInView.passwordInput])
        view.addSubview(logInView)
        view.addSubview(logInView.logInButton)
        view.addSubview(logInView.logoView)
        view.addSubview(logInView.loginInput)
        view.addSubview(logInView.passwordInput)
        
        logInView.logInButton.addTarget(self, action: #selector(toProfileViewController), for: .touchUpInside)
        setupConstraints()
    }
    
    @objc func toProfileViewController() {
        // почему-то ни push, ни present не работают, ругается на unexpected nil в ProfileViewController, не понимаю, почему( нагуглил другой способ решения, через StoryBoard ID
        //let profileVC = ProfileViewController()
        //navigationController?.pushViewController(profileVC, animated: true)
        //navigationController?.present(profileVC, animated: true, completion: nil)
        let story = UIStoryboard(name: "Main", bundle: nil)
        let controller = story.instantiateViewController(identifier: "ProfileViewController") as! ProfileViewController
        self.present(controller, animated: true, completion: nil)
    }
    
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            // logo
            logInView.logoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 120),
            logInView.logoView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logInView.logoView.widthAnchor.constraint(equalToConstant: 100),
            logInView.logoView.heightAnchor.constraint(equalToConstant: 100),
            // loginInput
            logInView.loginInput.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            logInView.loginInput.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            logInView.loginInput.topAnchor.constraint(equalTo: logInView.logoView.bottomAnchor, constant: 120),
            logInView.loginInput.heightAnchor.constraint(equalToConstant: 50),
            //passwordInput
            logInView.passwordInput.trailingAnchor.constraint(equalTo: logInView.loginInput.trailingAnchor),
            logInView.passwordInput.leadingAnchor.constraint(equalTo: logInView.loginInput.leadingAnchor),
            logInView.passwordInput.heightAnchor.constraint(equalToConstant: 50),
            logInView.passwordInput.topAnchor.constraint(equalTo: logInView.loginInput.bottomAnchor),
            // button
            logInView.logInButton.trailingAnchor.constraint(equalTo: logInView.loginInput.trailingAnchor),
            logInView.logInButton.leadingAnchor.constraint(equalTo: logInView.loginInput.leadingAnchor),
            logInView.logInButton.heightAnchor.constraint(equalToConstant: 50),
            logInView.logInButton.topAnchor.constraint(equalTo: logInView.passwordInput.bottomAnchor, constant: 16)
        ])
        
    }
}
