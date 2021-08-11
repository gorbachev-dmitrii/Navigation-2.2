//
//  LogInViewController.swift
//  Navigation
//
//  Created by Dima Gorbachev on 28.01.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {
    
    //MARK: Properties
    let logInView = LogInView()
    
    weak var inspectorDelegate: LoginViewControllerDelegate?
    
    private let generatePassword: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.backgroundColor = .red
        button.setTitle("Generate", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
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
    
    private let container: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(logInView)
        view.addSubview(generatePassword)
        view.addSubview(container)
        logInView.translatesAutoresizingMaskIntoConstraints = false
        [logInView.logoView, logInView.logInButton, logInView.loginInput, logInView.passwordInput].forEach({
            logInView.addSubview($0)
        })
        logInView.setupTextField(textFields: [logInView.loginInput, logInView.passwordInput])
        logInView.logInButton.addTarget(self, action: #selector(toProfileViewController), for: .touchUpInside)
        generatePassword.addTarget(self, action: #selector(onGenerateTap), for: .touchUpInside)
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
    
    @objc func onGenerateTap() {
        let activityView = UIActivityIndicatorView(style: .medium)
        container.addSubview(activityView)
        activityView.startAnimating()
        let brut = BrutForcer()
        let randowPassword = self.generatePass(length: 4)
        print(randowPassword)
        let queue = OperationQueue()
        queue.addOperation {
            let pass = brut.bruteForce(passwordToUnlock: randowPassword)
            OperationQueue.main.addOperation {
                activityView.stopAnimating()
                activityView.hidesWhenStopped = true
                self.logInView.passwordInput.isSecureTextEntry = false
                self.logInView.passwordInput.text = pass
            }
        }
    }
    
    private func generatePass(length: Int) -> String {
        let string = String((0..<length).map{ _ in
            String().printable.randomElement()!
        })
        return string
    }
    
    @objc func toProfileViewController() {
        
        #if DEBUG
        let testUser = TestUserService()
        let vc = ProfileViewController(userService: testUser, username: logInView.loginInput.text!)
        navigationController?.pushViewController(vc, animated: true)
        #elseif RELEASE
        let currentUser = CurrentUserService()
        let vc = ProfileViewController(userService: currentUser, username: logInView.loginInput.text!)
        navigationController?.pushViewController(vc, animated: true)
        #endif
        
        if let login = logInView.loginInput.text,
           let password = logInView.passwordInput.text,
           let delegate = inspectorDelegate {
            print(delegate.checkInputData(login: login, password: password))
        }
    }
    
    // MARK: Constraints
    func setupConstraints() {
        NSLayoutConstraint.activate([
            // scrollView
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
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
            logInView.loginInput.trailingAnchor.constraint(equalTo: logInView.trailingAnchor, constant: -25),
            logInView.loginInput.leadingAnchor.constraint(equalTo: logInView.leadingAnchor, constant: 25),
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
            logInView.logInButton.bottomAnchor.constraint(equalTo: logInView.bottomAnchor, constant: -16),
            
            generatePassword.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            generatePassword.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            
            container.leadingAnchor.constraint(equalTo: logInView.passwordInput.trailingAnchor),
            container.topAnchor.constraint(equalTo: logInView.passwordInput.topAnchor),
            container.bottomAnchor.constraint(equalTo: logInView.passwordInput.bottomAnchor),
            container.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
}

// MARK: LoginViewControllerDelegate

protocol LoginViewControllerDelegate: AnyObject {
    func checkInputData(login: String, password: String) -> String
}
