//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Dima Gorbachev on 11.03.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Photos"
        return label
    }()
    
    private let arrowImage: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(systemName: "arrow.forward")
        iv.tintColor = .black
        return iv
    }()
    
    private let firstImage = UIImageView()
    private let secondImage = UIImageView()
    private let thirdImage = UIImageView()
    private let fourthImage = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubviews(views: [firstImage, secondImage, thirdImage, fourthImage, titleLabel, arrowImage])
        setupConstraints()
        setupUIImage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUIImage() {
        let array = [firstImage, secondImage, thirdImage, fourthImage]
        for (index, image) in array.enumerated() {
            image.clipsToBounds = true
            image.translatesAutoresizingMaskIntoConstraints = false
            image.layer.cornerRadius = 6
            image.image = UIImage(named: String(index + 1))
        }
    }
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            
            arrowImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            arrowImage.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            
            firstImage.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            firstImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            firstImage.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            firstImage.widthAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width - 48) / 4),
            firstImage.heightAnchor.constraint(equalTo: firstImage.widthAnchor),
            
            secondImage.topAnchor.constraint(equalTo: firstImage.topAnchor),
            secondImage.bottomAnchor.constraint(equalTo: firstImage.bottomAnchor),
            secondImage.leadingAnchor.constraint(equalTo: firstImage.trailingAnchor, constant: 8),
            secondImage.widthAnchor.constraint(equalTo: firstImage.widthAnchor),
            secondImage.heightAnchor.constraint(equalTo: firstImage.widthAnchor),
            
            thirdImage.topAnchor.constraint(equalTo: firstImage.topAnchor),
            thirdImage.bottomAnchor.constraint(equalTo: firstImage.bottomAnchor),
            thirdImage.leadingAnchor.constraint(equalTo: secondImage.trailingAnchor, constant: 8),
            thirdImage.widthAnchor.constraint(equalTo: firstImage.widthAnchor),
            thirdImage.heightAnchor.constraint(equalTo: firstImage.widthAnchor),
            
            fourthImage.topAnchor.constraint(equalTo: firstImage.topAnchor),
            fourthImage.bottomAnchor.constraint(equalTo: firstImage.bottomAnchor),
            fourthImage.leadingAnchor.constraint(equalTo: thirdImage.trailingAnchor, constant: 8),
            fourthImage.widthAnchor.constraint(equalTo: firstImage.widthAnchor),
            fourthImage.heightAnchor.constraint(equalTo: firstImage.widthAnchor)
        ])
    }
}
