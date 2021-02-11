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
    let profileHeader = ProfileHeaderView()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: String(describing: PostTableViewCell.self))
        tableView.delegate = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileHeader.setStatusButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        profileHeader.statusTextField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        view.addSubview(tableView)
        
        profileHeader.addSubview(profileHeader.avatarImageView)
        profileHeader.addSubview(profileHeader.fullNameLabel)
        profileHeader.addSubview(profileHeader.statusLabel)
        profileHeader.addSubview(profileHeader.statusTextField)
        profileHeader.addSubview(profileHeader.setStatusButton)
        setupConstraints()
    }
    
    
    @objc func buttonPressed() {
        if let inputText = profileHeader.statusLabel.text {
            statusText = inputText
        } else {
            print("empty input")
        }
        print(profileHeader.statusLabel.text ?? "status is empty")
    }

    @objc func statusTextChanged(_ textField: UITextField) {
        if let temp = profileHeader.statusTextField.text {
            statusText = temp
        }
    }
    // MARK: Constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            profileHeader.avatarImageView.topAnchor.constraint(equalTo: profileHeader.topAnchor, constant: 16),
            profileHeader.avatarImageView.leadingAnchor.constraint(equalTo: profileHeader.leadingAnchor, constant: 16),
            profileHeader.avatarImageView.widthAnchor.constraint(equalToConstant: 125),
            profileHeader.avatarImageView.heightAnchor.constraint(equalToConstant: 125),

            profileHeader.fullNameLabel.topAnchor.constraint(equalTo: profileHeader.topAnchor, constant: 16),
            profileHeader.fullNameLabel.leadingAnchor.constraint(equalTo: profileHeader.avatarImageView.trailingAnchor, constant: 16),
            profileHeader.fullNameLabel.trailingAnchor.constraint(equalTo: profileHeader.trailingAnchor, constant: -16),

            profileHeader.statusLabel.topAnchor.constraint(equalTo: profileHeader.fullNameLabel.bottomAnchor, constant: 16),
            profileHeader.statusLabel.leadingAnchor.constraint(equalTo: profileHeader.fullNameLabel.leadingAnchor),
            profileHeader.statusLabel.trailingAnchor.constraint(equalTo: profileHeader.fullNameLabel.trailingAnchor),

            profileHeader.statusTextField.topAnchor.constraint(equalTo: profileHeader.statusLabel.bottomAnchor, constant: 16),
            profileHeader.statusTextField.leadingAnchor.constraint(equalTo: profileHeader.statusLabel.leadingAnchor, constant: 1),
            profileHeader.statusTextField.trailingAnchor.constraint(equalTo: profileHeader.trailingAnchor, constant: -15),
            profileHeader.statusTextField.heightAnchor.constraint(equalToConstant: 40),

            profileHeader.setStatusButton.leadingAnchor.constraint(equalTo: profileHeader.leadingAnchor, constant: 16),
            profileHeader.setStatusButton.trailingAnchor.constraint(equalTo: profileHeader.trailingAnchor, constant: -16),
            profileHeader.setStatusButton.bottomAnchor.constraint(equalTo: profileHeader.bottomAnchor, constant: -16),
            profileHeader.setStatusButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
// MARK: UITableViewDelegate
extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 220
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .zero
    }
}
// MARK: UITableViewDataSource
extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PostTableViewCell = tableView.dequeueReusableCell(withIdentifier: String(describing: PostTableViewCell.self), for: indexPath) as! PostTableViewCell
        cell.post = posts[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return profileHeader
    }
}
