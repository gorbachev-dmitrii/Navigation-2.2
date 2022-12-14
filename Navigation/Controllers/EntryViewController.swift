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
    
    var onShowNext: (() -> Void)?

    private let logoView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        return imageView
    }()
    
    private lazy var registerButton: CustomButton = {
        let button = CustomButton(title: "Reg", titleColor: .white) {
            print("tapped")
        }
        button.backgroundColor = .black
        button.layer.cornerRadius = 10
        return button
    }()
    
    private lazy var haveAccountButton: CustomButton = {
        let button = CustomButton(title: "Est acc", titleColor: .black) {
            print("tapped2")
            self.loginButtonTapped()
        }
        return button
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.backgroundColor = .brown
        label.text = "feedCheckLabel".localized
        return label
    }()

    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        view.addSubview(label)
        view.addSubviews(views: [registerButton, haveAccountButton, logoView])
        setupConstraints()
    }
    
    private func loginButtonTapped() {
        self.onShowNext?()
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
        
        label.snp.makeConstraints { make in
            make.centerX.equalTo(view.center.x)
            make.centerY.equalTo(view.center.y)
        }
        
        logoView.snp.makeConstraints { make in
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.top.equalTo(125)
            make.bottom.equalTo(-355)
        }
    }
}
