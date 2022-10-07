//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Dima Gorbachev on 02.02.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit
import iOSIntPackage
import StorageService

class PostTableViewCell: UITableViewCell {
    
    var post: PostData? {
        didSet {
            titleLabel.text = post?.author
            descriptionLabel.text = post?.description
            if let likes = post?.likes, let views = post?.views {
                likesLabel.text = "postCellLikes".localized + " " + String(likes)
                viewsLabel.text = "postCellViews".localized + " " + String(views)
            }
            
        }
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let cellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .systemGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let viewsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let likesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
     
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        [titleLabel, cellImageView, descriptionLabel, viewsLabel, likesLabel].forEach({
            contentView.addSubview($0)
        })        
        setupConstraints()
        setupGestureRecognizer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupGestureRecognizer() {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(doubleClickHandler))
        gestureRecognizer.numberOfTapsRequired = 2
        contentView.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc private func doubleClickHandler() {
        if let post = post {
            CoreDataManager.shared.saveFavourite(post: post)
        } else {
            return
        }
            
    }
    
    func makeFilter() {
        guard let imageName = post?.image else { return }
        guard let source = UIImage(named: imageName) else { return }
        ImageProcessor().processImage(sourceImage: source, filter: .noir) { (image) in
            cellImageView.image = image
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: cellImageView.topAnchor, constant: -12),
            
            cellImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cellImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            cellImageView.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: -16),
            cellImageView.heightAnchor.constraint(equalTo: contentView.widthAnchor),
            cellImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: cellImageView.bottomAnchor, constant: 16),
            descriptionLabel.bottomAnchor.constraint(equalTo: likesLabel.topAnchor, constant: -16),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            likesLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            likesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            likesLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            viewsLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            viewsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            viewsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
    
}
