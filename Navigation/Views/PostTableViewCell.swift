//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Dima Gorbachev on 30.05.2023.
//  Copyright © 2023 Artem Novichkov. All rights reserved.
//

import UIKit
import SnapKit
import StorageService

class PostTableViewCell: UITableViewCell {
    
    var post: PostData? {
        didSet {
            if let image = post?.image, let likes = post?.likes {
                postImage.image = UIImage(named: image)
                likesLabel.text = "\(likes)"
            }
            usernameLabel.text = post?.author
            userImage.image = UIImage(named: "userImage")
            postText.text = post?.description
        }
    }
    
    var onAddFavTap: (() -> Void)?
    
    private lazy var headerContainer: UIView = {
        let view = UIView()
        view.addSubview(userImage)
        view.addSubview(usernameLabel)
        return view
    }()
    
    private lazy var mainContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "CustomMilky")
        view.addSubview(postText)
        view.addSubview(postImage)
        return view
    }()
    
    private lazy var footerContainer: UIView = {
        let view = UIView()
        view.addSubview(button)
        view.addSubview(likesLabel)
        view.addSubview(addFavorite)
        view.layer.borderWidth = 1
        view.backgroundColor = .red
        return view
    }()
    
    private lazy var userImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var usernameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var postText: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var postImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var likesLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var button: CustomButton = {
        let button = CustomButton(title: "", titleColor: .clear) {
            print("aalalalla")
        }
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        return button
    }()
    
    private lazy var addFavorite: CustomButton = {
        let button = CustomButton(title: "", titleColor: .clear) {
            self.onAddFavTap?()
        }
        button.setImage(UIImage(systemName: "bookmark"), for: .normal)
        return button
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(headerContainer)
        contentView.addSubview(mainContainer)
        contentView.addSubview(footerContainer)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        
        // MARK: header container
        
        headerContainer.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(92)
        }
        
        userImage.snp.makeConstraints { make in
            make.leading.top.equalTo(16)
            make.width.height.equalTo(60)
        }
        
        usernameLabel.snp.makeConstraints { make in
            make.leading.equalTo(userImage.snp.trailing).offset(24)
            make.top.equalTo(userImage.snp.top)
        }
        
        // MARK: main container
        
        mainContainer.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(headerContainer.snp.bottom)
        }
        
        postText.snp.makeConstraints { make in
            make.leading.top.equalTo(16)
            make.trailing.equalTo(-16)
            make.bottom.equalTo(postImage.snp.top)
        }
        
        postImage.snp.makeConstraints { make in
            make.top.equalTo(postText.snp.bottom)
            make.bottom.equalToSuperview()
            make.leading.trailing.equalTo(postText)
            make.height.equalTo(headerContainer.snp.width).inset(50)
        }
        
        // MARK: footer container
        
        footerContainer.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(mainContainer.snp.bottom)
            make.height.equalTo(50)
        }
        
        button.snp.makeConstraints { make in
            make.leading.equalTo(16)
            make.centerY.equalToSuperview()
        }
        
        likesLabel.snp.makeConstraints { make in
            make.leading.equalTo(button.snp.trailing).offset(10)
            make.centerY.equalToSuperview()
        }
        
        addFavorite.snp.makeConstraints { make in
            make.trailing.equalTo(-23)
            make.centerY.equalToSuperview()
        }
    }
}
