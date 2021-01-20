//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Dima Gorbachev on 16.01.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class ProfileHeaderView: UIView {
    
    let userImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "userImage.png")
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = imageView.frame.height / 2
        return imageView
    }()
    
    let statusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.layer.backgroundColor = UIColor.white.cgColor
        label.textColor = .black
        label.text = ""
        label.layer.cornerRadius = 12
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.black.cgColor
        return label
    }()
    let userNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        label.text = "new name"
        return label
    }()
    
    lazy var statusInput: UITextField = {
       let textInput = UITextField()
        textInput.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        textInput.placeholder = "Waiting for something..."
        textInput.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return textInput
    }()
    
    
    lazy var showStatusButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        button.setTitle("Set status", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 4
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        return button
    }()
    
    @objc func buttonPressed() {
        statusLabel.text = statusText
    }
    
    private var statusText: String = ""
    
    @objc func statusTextChanged(_ textField: UITextField) {
        if let temp = statusInput.text {
            statusText = temp
        }
    }
}
