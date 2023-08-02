//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Dima Gorbachev on 16.01.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit
import SnapKit

class ProfileHeaderView: UIView {
    var onShowEdit: (() -> Void)?

    let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.borderWidth = 3
        imageView.isUserInteractionEnabled = true
        imageView.layer.masksToBounds = false
        imageView.clipsToBounds = true
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.image = UIImage(named: "userImage")
        return imageView
    }()
    
    private lazy var fullNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .label
        return label
    }()
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .label
        return label
    }()
    
    private lazy var statusTextField: CustomTextField = {
        let textField = CustomTextField(placeholder: "profileHeaderPlaceholder".localized,
                                        textColor: UIColor(named: "CustomGray")!,
                                        bckgColor: .white, onText: nil)
        textField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        textField.placeholder = "profileHeaderPlaceholder".localized
        textField.textColor = .label
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        return textField
    }()
    
    private lazy var setStatusButton: CustomButton = {
        let button = CustomButton(title: "profileHeaderSetStatusButton".localized, titleColor: .white) {
            self.changeText()
            self.onShowEdit?()
        }
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 4
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        return button
    }()
    
    func changeText() {
        statusLabel.text = statusTextField.text
        statusTextField.text = ""
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        avatarImageView.layer.cornerRadius = avatarImageView.frame.height / 2
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.addSubviews(views: [avatarImageView, setStatusButton, statusLabel, statusTextField, fullNameLabel])
        setupSnapConstraints()
        self.backgroundColor = .white
        let recognizeTap = UITapGestureRecognizer(target: self, action: #selector(tap))
        self.avatarImageView.addGestureRecognizer(recognizeTap)
    }
    
    @objc func tap() {
        print("tapped")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSnapConstraints() {
        avatarImageView.snp.makeConstraints { (make) in
            make.leading.top.equalTo(16)
            make.width.equalTo(125)
            make.height.equalTo(avatarImageView.snp.width)
        }
        fullNameLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(avatarImageView.snp.trailing).offset(16)
            make.top.equalTo(16)
            make.trailing.equalTo(-16)
        }
        statusLabel.snp.makeConstraints { (make) in
            make.top.equalTo(fullNameLabel.snp.bottom).offset(16)
            make.leading.equalTo(fullNameLabel.snp.leading)
            make.trailing.equalTo(fullNameLabel.snp.trailing)
        }
        statusTextField.snp.makeConstraints { (make) in
            make.top.equalTo(statusLabel.snp.bottom).offset(16)
            make.leading.equalTo(statusLabel.snp.leading).offset(1)
            make.trailing.equalTo(-15)
            make.height.equalTo(40)
        }
        
        setStatusButton.snp.makeConstraints { (make) in
            make.leading.equalTo(16)
            make.trailing.bottom.equalTo(-16)
            make.height.equalTo(50)
        }
    }
    
}
