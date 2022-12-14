//
//  SignInViewController.swift
//  Navigation
//
//  Created by Dima Gorbachev on 15.12.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import UIKit

final class SignInViewController: UIViewController {
    //MARK: Properties
    
    var onShowNext: (() -> Void)?
    
    private lazy var loginInput: CustomTextField = {
        let input = CustomTextField(
            placeholder: "loginInputPlaceholder".localized,
            textColor: UIColor(named: "CustomBlack")!,
            bckgColor: .white) { text in
            }
        input.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return input
    }()
    
    private lazy var passwordInput: CustomTextField = {
        let input = CustomTextField(
            placeholder: "passwordInputPlaceholder".localized,
            textColor: UIColor(named: "CustomBlack")!,
            bckgColor: .white) { text in
                self.signInButton.isEnabled = true
            }
        input.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        input.isSecureTextEntry = true
        return input
    }()
    
    private lazy var signInButton: CustomButton = {
        let button = CustomButton(title: "signInButton".localized.uppercased(), titleColor: .white) {
            self.signInButtonTapped()
        }
        button.backgroundColor = UIColor(named: "CustomBlack")
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        button.layer.cornerRadius = 10
        button.isEnabled = false
        return button
    }()
    
    private lazy var helloLabel = {
        let label = UILabel()
        label.text = "helloText".localized
        label.textColor = UIColor(named: "LabelColor")
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    
    private lazy var hintLabel = {
        let label = UILabel()
        label.text = "hintText".localized
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubviews(views: [loginInput, passwordInput, signInButton, helloLabel, hintLabel])
        setupConstraints()
        setupTextField(textFields: [loginInput, passwordInput])
    }
    
    private func signInButtonTapped() {
        self.onShowNext?()
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
            make.bottom.equalTo(signInButton.snp.top).inset(-158)
            make.height.equalTo(48)
        }
        
        signInButton.snp.makeConstraints { make in
            make.leading.equalTo(93)
            make.trailing.equalTo(-93)
            make.bottom.equalTo(-245)
        }
        
        hintLabel.snp.makeConstraints { make in
            make.leading.equalTo(98)
            make.trailing.equalTo(-98)
            make.bottom.equalTo(loginInput.snp.top).inset(-12)
        }
        
        helloLabel.snp.makeConstraints { make in
            make.leading.equalTo(109)
            make.trailing.equalTo(-109)
            make.bottom.equalTo(hintLabel.snp.top).inset(-26)
        }
    }
    
    
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
}
