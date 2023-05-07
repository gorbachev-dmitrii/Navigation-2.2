//
//  EntryViewController.swift
//  Navigation
//
//  Created by Dima Gorbachev on 14.12.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import UIKit
import SnapKit

final class EntryViewController: UIViewController {
    //MARK: Properties
    
    var onShowNext: ((_: String) -> Void)?

    private let logoView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        return imageView
    }()
    
    private lazy var registerButton: CustomButton = {
        let button = CustomButton(title: "registerButton".localized.uppercased(), titleColor: .white) {
            self.registerButtonTapped()
        }
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        button.backgroundColor = UIColor(named: "CustomBlack")
        button.layer.cornerRadius = 10
        return button
    }()
    
    private lazy var haveAccountButton: CustomButton = {
        let button = CustomButton(title: "haveAccButton".localized, titleColor: .black) {
            self.loginButtonTapped()
        }
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return button
    }()

    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubviews(views: [registerButton, haveAccountButton, logoView])
        setupConstraints()
    }
    
    private func loginButtonTapped() {
        self.onShowNext?("signIn")
    }
    
    private func registerButtonTapped() {
        self.onShowNext?("signUp")
    }
    
    //MARK: Constraints
    
    private func setupConstraints() {
        registerButton.snp.makeConstraints { make in
            make.leading.equalTo(55)
            make.trailing.equalTo(-55)
            make.bottom.equalTo(haveAccountButton.snp.top).inset(-30)
        }
        
        haveAccountButton.snp.makeConstraints { make in
            make.leading.equalTo(128)
            make.trailing.equalTo(-128)
            make.bottom.equalTo(-150)
        }
        
        logoView.snp.makeConstraints { make in
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.top.equalTo(125)
            make.bottom.equalTo(-355)
        }
    }
}
