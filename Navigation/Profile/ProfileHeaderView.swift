//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Dima Gorbachev on 16.01.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class ProfileHeaderView: UIView {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var statusTextField: UITextField!
    @IBOutlet weak var setStatusButton: UIButton!
    
    override func layoutSubviews() {
        avatarImageView.image = UIImage(named: "userImage.png")
        avatarImageView.layer.borderWidth = 3
        avatarImageView.layer.borderColor = UIColor.white.cgColor
        avatarImageView.layer.cornerRadius = avatarImageView.frame.height / 2
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        
        statusLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        statusLabel.textColor = .gray
        statusLabel.text = "Waiting for something"

        fullNameLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        fullNameLabel.textColor = .black
        fullNameLabel.text = "new name"
        
        statusTextField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        statusTextField.placeholder = "Waiting for something..."
        statusTextField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        statusTextField.textColor = .black
        statusTextField.layer.cornerRadius = 12
        statusTextField.layer.borderWidth = 1
        statusTextField.layer.borderColor = UIColor.black.cgColor
        
        setStatusButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        setStatusButton.setTitle("Set status", for: .normal)
        setStatusButton.setTitleColor(.white, for: .normal)
        setStatusButton.backgroundColor = .systemBlue
        setStatusButton.layer.cornerRadius = 4
        setStatusButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        setStatusButton.layer.shadowRadius = 4
        setStatusButton.layer.shadowColor = UIColor.black.cgColor
        setStatusButton.layer.shadowOpacity = 0.7
    }
    
    @objc func buttonPressed() {
        statusLabel.text = statusText
    }
    
    private var statusText: String = ""
    
    @objc func statusTextChanged(_ textField: UITextField) {
        if let temp = statusTextField.text {
            statusText = temp
        }
    }
}
