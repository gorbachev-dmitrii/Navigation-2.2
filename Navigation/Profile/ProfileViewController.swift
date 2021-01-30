//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Dima Gorbachev on 16.01.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private var statusText: String = ""
    @IBOutlet weak var profileHeaderView: ProfileHeaderView!
    
    let newButton: UIButton! = {
        let button = UIButton()
        button.setTitle("new button", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(newButton)
        profileHeaderView.setStatusButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        profileHeaderView.statusTextField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        
        NSLayoutConstraint.activate([
            newButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            newButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            newButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    @objc func buttonPressed() {
        profileHeaderView.statusLabel.text = statusText
        print(profileHeaderView.statusLabel.text ?? "status is empty")
    }
    
    @objc func statusTextChanged(_ textField: UITextField) {
        if let temp = profileHeaderView.statusTextField.text {
            statusText = temp
        }
    }
}
