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
   
    private let containerView: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(logInView)
        logInView.translatesAutoresizingMaskIntoConstraints = false
        [logInView.logoView, logInView.logInButton, logInView.loginInput, logInView.passwordInput].forEach({
            logInView.addSubview($0)
        })
        logInView.setupTextField(textFields: [logInView.loginInput, logInView.passwordInput])
        logInView.logInButton.addTarget(self, action: #selector(toProfileViewController), for: .touchUpInside)
        setupConstraints()
    }
    
    // MARK: Keyboard observers
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    // MARK: Keyboard actions
    @objc fileprivate func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            scrollView.contentInset.bottom = keyboardSize.height
            scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        }
    }

    @objc fileprivate func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset.bottom = .zero
        scrollView.verticalScrollIndicatorInsets = .zero
    }
    
    @objc func toProfileViewController() {
        // почему-то ни push, ни present не работают, ругается на unexpected nil в ProfileViewController, не понимаю, почему( нагуглил другой способ решения, через StoryBoard ID
        //let profileVC = ProfileViewController()
        //navigationController?.pushViewController(profileVC, animated: true)
        //navigationController?.present(profileVC, animated: true, completion: nil)
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyBoard.instantiateViewController(identifier: "ProfileViewController") as! ProfileViewController
        navigationController?.pushViewController(controller, animated: true)
        
    }
    
    // MARK: Constraints
    func setupConstraints() {
        NSLayoutConstraint.activate([
            // scrollView
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            // container
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            // loginView
            logInView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            logInView.topAnchor.constraint(equalTo: containerView.topAnchor),
            logInView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            logInView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            // logo
            logInView.logoView.topAnchor.constraint(equalTo: logInView.topAnchor, constant: 120),
            logInView.logoView.centerXAnchor.constraint(equalTo: logInView.centerXAnchor),
            logInView.logoView.widthAnchor.constraint(equalToConstant: 100),
            logInView.logoView.heightAnchor.constraint(equalToConstant: 100),
            // loginInput
            logInView.loginInput.trailingAnchor.constraint(equalTo: logInView.trailingAnchor, constant: -16),
            logInView.loginInput.leadingAnchor.constraint(equalTo: logInView.leadingAnchor, constant: 16),
            logInView.loginInput.topAnchor.constraint(equalTo: logInView.logoView.bottomAnchor, constant: 120),
            logInView.loginInput.heightAnchor.constraint(equalToConstant: 50),
            // passwordInput
            logInView.passwordInput.trailingAnchor.constraint(equalTo: logInView.loginInput.trailingAnchor),
            logInView.passwordInput.leadingAnchor.constraint(equalTo: logInView.loginInput.leadingAnchor),
            logInView.passwordInput.heightAnchor.constraint(equalToConstant: 50),
            logInView.passwordInput.topAnchor.constraint(equalTo: logInView.loginInput.bottomAnchor),
            // button
            logInView.logInButton.trailingAnchor.constraint(equalTo: logInView.loginInput.trailingAnchor),
            logInView.logInButton.leadingAnchor.constraint(equalTo: logInView.loginInput.leadingAnchor),
            logInView.logInButton.heightAnchor.constraint(equalToConstant: 50),
            logInView.logInButton.topAnchor.constraint(equalTo: logInView.passwordInput.bottomAnchor, constant: 16),
            logInView.logInButton.bottomAnchor.constraint(equalTo: logInView.bottomAnchor, constant: 24)
        ])
    }
}

extension UIView {
    func roundCorners(cornerRadius: Double) {
        self.layer.cornerRadius = CGFloat(cornerRadius)
            self.clipsToBounds = true
            self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
}
