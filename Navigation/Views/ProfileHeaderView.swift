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
    var onAvatarTapped: (() -> Void)?
    
    lazy var userAvatar: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.borderWidth = 3
        imageView.isUserInteractionEnabled = true
        imageView.layer.masksToBounds = false
        imageView.clipsToBounds = true
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.image = UIImage(named: "userImage")
        return imageView
    }()
    
    lazy var fullName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .label
        return label
    }()
    
    lazy var jobName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textColor = UIColor(named: "CustomGray")
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = 20.0
        [fullName, jobName].forEach({stack.addArrangedSubview($0)})
        return stack
    }()
    
    private lazy var editProfile: CustomButton = {
        let button = CustomButton(title: "profileHeaderEdit".localized, titleColor: .white) {
            self.onShowEdit?()
        }
        button.backgroundColor = UIColor(named: "CustomOrange")
        button.layer.cornerRadius = 4
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        return button
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        userAvatar.layer.cornerRadius = userAvatar.frame.height / 2
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.addSubviews(views: [userAvatar, editProfile, stackView])
        setupConstraints()
        self.backgroundColor = .white
        let recognizeTap = UITapGestureRecognizer(target: self, action: #selector(tap))
        self.userAvatar.addGestureRecognizer(recognizeTap)
    }
    
    @objc func tap() {
//        print("tapped")
        self.onAvatarTapped?()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        userAvatar.snp.makeConstraints { (make) in
            make.leading.top.equalTo(16)
            make.width.equalTo(125)
            make.height.equalTo(userAvatar.snp.width)
        }
        
        editProfile.snp.makeConstraints { (make) in
            make.leading.equalTo(16)
            make.trailing.bottom.equalTo(-16)
            make.height.equalTo(50)
        }
        
        stackView.snp.makeConstraints { make in
            make.leading.equalTo(userAvatar.snp.trailing).offset(16)
            make.centerY.equalTo(userAvatar.snp.centerY)
        }
    }
}
