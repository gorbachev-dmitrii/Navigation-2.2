//
//  RegistrationViewController.swift
//  Navigation
//
//  Created by Dima Gorbachev on 15.12.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import UIKit
import SnapKit

final class SignUpViewController: UIViewController {
    
    // MARK: Properties
    
    var onShowNext: (() -> Void)?
    var inspectorDelegate: LoginDelegate?
    
    private lazy var loginInput: CustomTextField = {
        let input = CustomTextField(
            placeholder: "loginInputPlaceholder".localized,
            textColor: UIColor(named: "CustomGray")!,
            bckgColor: .white) { text in
            }
        input.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return input
    }()
    
    private lazy var passwordInput: CustomTextField = {
        let input = CustomTextField(
            placeholder: "passwordInputPlaceholder".localized,
            textColor: UIColor(named: "CustomGray")!,
            bckgColor: .white) { text in
                self.registerButton.isEnabled = true
                self.registerButton.alpha = 1
            }
        input.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        input.isSecureTextEntry = true
        return input
    }()
    
    private lazy var registerButton: CustomButton = {
        let button = CustomButton(title: "signInButton".localized.uppercased(), titleColor: .white) {
            self.registerButtonTapped()
        }
        button.backgroundColor = UIColor(named: "CustomBlack")
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        button.layer.cornerRadius = 10
        button.isEnabled = false
        button.alpha = 0.5
        return button
    }()
    
    private lazy var registerLabel = {
        let label = UILabel()
        label.text = "registerText".localized.uppercased()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = UIColor(named: "CustomBlack")
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private lazy var tipLabel = {
        let label = UILabel()
        label.text = "tipText".localized
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = UIColor(named: "CustomGray")
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    private lazy var acceptTermsLabel = {
        let label = UILabel()
        label.text = "termsText".localized
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = UIColor(named: "CustomGray")
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubviews(views: [loginInput, passwordInput, registerButton, tipLabel, registerLabel, acceptTermsLabel])
        setupConstraints()
    }
    
    private func registerButtonTapped() {
        if let login = loginInput.text, let password = passwordInput.text, let delegate = inspectorDelegate {
            if !login.isEmpty || !password.isEmpty {
                delegate.checkIfExists(login: login, password: password)
                self.onShowNext?()
            } else {
                print("Пустые поля")
            }
        }
    }
    
    private func setupConstraints() {
        loginInput.snp.makeConstraints { make in
            make.leading.equalTo(57)
            make.trailing.equalTo(-57)
            make.bottom.equalTo(passwordInput.snp.top)
            make.height.equalTo(48)
        }
        
        passwordInput.snp.makeConstraints { make in
            make.leading.equalTo(57)
            make.trailing.equalTo(-57)
            make.bottom.equalTo(registerButton.snp.top).inset(-63)
            make.height.equalTo(48)
        }
        
        registerLabel.snp.makeConstraints { make in
            make.leading.equalTo(76)
            make.trailing.equalTo(-76)
            make.top.equalTo(148)
        }
        
        tipLabel.snp.makeConstraints { make in
            make.leading.equalTo(80)
            make.trailing.equalTo(-80)
            make.top.equalTo(269)
        }
        
        registerButton.snp.makeConstraints { make in
            make.leading.equalTo(56)
            make.trailing.equalTo(-56)
            make.bottom.equalTo(-271)
        }
        
        acceptTermsLabel.snp.makeConstraints { make in
            make.leading.equalTo(56)
            make.trailing.equalTo(-56)
            make.top.equalTo(registerButton.snp.bottom).inset(-20)
        }
    }
}
