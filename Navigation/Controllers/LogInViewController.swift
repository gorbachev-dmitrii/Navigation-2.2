//
//  LogInViewController.swift
//  Navigation
//
//  Created by Dima Gorbachev on 28.01.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit
import SnapKit

class LogInViewController: UIViewController {
    
    //MARK: Properties
    var inspectorDelegate: LoginDelegate?
    weak var coordinator: LoginCoordinator?
    
    private let logoView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        return imageView
    }()
    
    private lazy var loginInput: CustomTextField = {
        let input = CustomTextField(
            placeholder: "loginInputPlaceholder".localized,
            textColor: .black,
            bckgColor: .systemGray6) { text in
            }
        input.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return input
    }()
    
    private lazy var passwordInput: CustomTextField = {
        let input = CustomTextField(
            placeholder: "passwordInputPlaceholder".localized,
            textColor: .black,
            bckgColor: .systemGray6) { text in
                self.loginButton.isEnabled = true
            }
        input.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        input.isSecureTextEntry = true
        return input
    }()
    
    private lazy var loginButton: CustomButton = {
        let button = CustomButton(title: "loginButton".localized, titleColor: .white) {
            self.loginButtonTapped()
        }
        button.setBackgroundImage(UIImage(named: "blue_pixel"), for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10
        button.isEnabled = false
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
    
    var onShowNext: ((String, UserService) -> Void)?
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
        view.addSubviews(views: [scrollView])
        scrollView.addSubview(containerView)
        containerView.addSubviews(views: [logoView, loginInput, passwordInput, loginButton])
        view.disableAutoresizingMask(views: [containerView, scrollView, logoView, loginInput, passwordInput])
        setupTextField(textFields: [loginInput, passwordInput])
        setupConstraints()
    }
    
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
    // MARK: Support Functions
    private func setupTextField(textFields: [UITextField]) {
        for textField in textFields {
            textField.layer.borderColor = UIColor.lightGray.cgColor
            textField.layer.borderWidth = 0.5
            textField.layer.cornerRadius = 10
            textField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
            textField.tintColor = .blue
            textField.autocapitalizationType = .none
        }
    }
    
    private func loginButtonTapped() {
        if let login = loginInput.text, let password = passwordInput.text, let delegate = inspectorDelegate {
            if !login.isEmpty || !password.isEmpty {
                let testUser = TestUserService()
                self.onShowNext?(login, testUser)
                print("a;a;a;;a")
                print(delegate.checkInputData(login: login, password: password))
            } else {
                createLoginAlert()
            }
        } else {
            print("smth is nil")
        }
    }
    
    private func createLoginAlert() {
        let alert = UIAlertController(title: "Ошибка авторизации", message: "Логин и/или пароль не заполнены", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: Constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // scrollView
//            scrollView.snp.makeConstraints({ make in
//                <#code#>
//            })
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
            loginButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16)
        ])
    }
}


