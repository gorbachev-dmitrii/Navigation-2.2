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
    weak var inspectorDelegate: LoginViewControllerDelegate?
    
    private let logoView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        return imageView
    }()
    
    private let loginInput: UITextField = {
        let input = UITextField()
        input.placeholder = "Email or phone"
        input.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return input
    }()
    
    private let passwordInput: UITextField = {
        let input = UITextField()
        input.placeholder = "Password"
        input.isSecureTextEntry = true
        input.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        return input
    }()
    
    private lazy var loginButton: MyButton = {
        let button = MyButton(title: "Login", titleColor: .white) {
            self.loginButtonTapped()
        }
        button.setBackgroundImage(UIImage(named: "blue_pixel"), for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10
        return button
    }()
    
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
        return container
    }()
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
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
        containerView.addSubviews(views: [logoView, loginInput, passwordInput, loginButton])
        view.disableAutoresizingMask(views: [containerView, scrollView, logoView, loginInput, passwordInput])
        setupTextField(textFields: [loginInput, passwordInput])
        view.addSubview(generatePassword)
        view.addSubview(container)
        //        logInView.translatesAutoresizingMaskIntoConstraints = false
        //        [logInView.logoView, logInView.logInButton, logInView.loginInput, logInView.passwordInput].forEach({
        //            logInView.addSubview($0)
        //        })
        //        logInView.setupTextField(textFields: [logInView.loginInput, logInView.passwordInput])
        //        logInView.logInButton.addTarget(self, action: #selector(toProfileViewController), for: .touchUpInside)
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
        }
    }
    
    func loginButtonTapped() {
        if let login = loginInput.text, let password = passwordInput.text, let delegate = inspectorDelegate {
            #if DEBUG
            let testUser = TestUserService()
            let vc = ProfileViewController(userService: testUser, username: login)
            navigationController?.pushViewController(vc, animated: true)
            #elseif RELEASE
            let currentUser = CurrentUserService()
            let vc = ProfileViewController(userService: currentUser, username: login)
            navigationController?.pushViewController(vc, animated: true)
            #endif
            print(delegate.checkInputData(login: login, password: password))
        }
    }
    
    @objc func onGenerateTap() {
        let activityView = UIActivityIndicatorView(style: .medium)
        container.addSubview(activityView)
        activityView.startAnimating()
        let brut = BrutForcer()
        let randowPassword = generatePass(length: 4)
        print(randowPassword)
        let queue = OperationQueue()
        queue.addOperation {
            let pass = brut.bruteForce(passwordToUnlock: randowPassword)
            OperationQueue.main.addOperation {
                activityView.stopAnimating()
                activityView.hidesWhenStopped = true
                self.passwordInput.isSecureTextEntry = false
                self.passwordInput.text = pass
            }
        }
    }
    
    func generatePass(length: Int) -> String {
        let string = String((0..<length).map{ _ in
            String().printable.randomElement()!
        })
        return string
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
        // logo
        logoView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 120),
        logoView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
        logoView.widthAnchor.constraint(equalToConstant: 100),
        logoView.heightAnchor.constraint(equalToConstant: 100),
        // loginInput
        
        loginInput.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
        loginInput.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
        loginInput.topAnchor.constraint(equalTo: logoView.bottomAnchor, constant: 120),
        loginInput.heightAnchor.constraint(equalToConstant: 50),
        // passwordInput
        passwordInput.trailingAnchor.constraint(equalTo: loginInput.trailingAnchor),
        passwordInput.leadingAnchor.constraint(equalTo: loginInput.leadingAnchor),
        passwordInput.heightAnchor.constraint(equalToConstant: 50),
        passwordInput.topAnchor.constraint(equalTo: loginInput.bottomAnchor),
        // button
        loginButton.trailingAnchor.constraint(equalTo: loginInput.trailingAnchor),
        loginButton.leadingAnchor.constraint(equalTo: loginInput.leadingAnchor),
        loginButton.heightAnchor.constraint(equalToConstant: 50),
        loginButton.topAnchor.constraint(equalTo: passwordInput.bottomAnchor, constant: 16),
        loginButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
        
        generatePassword.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        generatePassword.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
        
        container.leadingAnchor.constraint(equalTo: passwordInput.trailingAnchor),
        container.topAnchor.constraint(equalTo: passwordInput.topAnchor),
        container.bottomAnchor.constraint(equalTo: passwordInput.bottomAnchor),
        container.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
    ])
}

}

// MARK: LoginViewControllerDelegate

protocol LoginViewControllerDelegate: AnyObject {
    func checkInputData(login: String, password: String) -> String
}
