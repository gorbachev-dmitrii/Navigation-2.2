//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Dima Gorbachev on 16.01.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    // MARK: Properties
    private var statusText: String = ""
    let profileHeader = ProfileHeaderView()
    
    private let blurView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alpha = 0
        view.backgroundColor = .white
        return view
    }()
    
    private let cancelButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "xmark"), for: .normal)
        btn.alpha = 0
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: String(describing: PostTableViewCell.self))
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: String(describing: PhotosTableViewCell.self))
        tableView.delegate = self
        return tableView
    }()
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cancelButton.addTarget(self, action: #selector(cancelPressed), for: .touchUpInside)
        
        profileHeader.setStatusButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        profileHeader.statusTextField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        profileHeader.addSubview(blurView)
        view.addSubview(tableView)
        profileHeader.bringSubviewToFront(profileHeader.avatarImageView)
        blurView.addSubview(cancelButton)
        setupConstraints()
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tap))
        profileHeader.avatarImageView.addGestureRecognizer(tapRecognizer)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.isHidden = true
    }
    // MARK: Actions
    
    @objc func cancelPressed() {
        UIView.animate(withDuration: 0.3, animations: {
            self.cancelButton.alpha = 0
            self.profileHeader.avatarImageView.transform = CGAffineTransform.identity
        }, completion: {_ in
            UIView.animate(withDuration: 0.5, animations: {
                self.blurView.alpha = 0
            })
        })
    }
    
    @objc func tap() {
        UIView.animateKeyframes(withDuration: 0.8,
                                delay: 0,
                                options: [],
                                animations: {
                                    UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: {
                                        self.blurView.alpha = 0.75
                                        // смещаем frame по x и y
                                        let positionTransform = CGAffineTransform(translationX: (self.view.frame.width / 2) - (self.profileHeader.avatarImageView.frame.width / 2) - 16,y: (self.view.frame.height / 2) - self.profileHeader.avatarImageView.frame.height)
                                        let x = self.view.frame.width / self.profileHeader.avatarImageView.frame.width
                                        let sizeTransform = CGAffineTransform(scaleX: x, y: x)
                                        let transform = sizeTransform.concatenating(positionTransform)
                                        self.profileHeader.avatarImageView.transform = transform
                                    })
                                    UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 1, animations: {
                                        self.cancelButton.alpha = 1
                                    })
                                },
                                completion: nil)}
    
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
            
            blurView.leadingAnchor.constraint(equalTo: profileHeader.leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: profileHeader.trailingAnchor),
            blurView.heightAnchor.constraint(equalToConstant: view.frame.height),
            
            cancelButton.trailingAnchor.constraint(equalTo: blurView.trailingAnchor, constant: -10),
            cancelButton.topAnchor.constraint(equalTo: blurView.topAnchor, constant: 10)
        ])
    }
}
// MARK: UITableViewDelegate
extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        } else {
            return 220
        }
        
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .zero
    }
}
// MARK: UITableViewDataSource
extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 0
        } else {
            return posts.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell: PhotosTableViewCell = tableView.dequeueReusableCell(withIdentifier: String(describing: PhotosTableViewCell.self), for: indexPath) as! PhotosTableViewCell
            cell.selectionStyle = .default
            return cell
        } else {
            let cell: PostTableViewCell = tableView.dequeueReusableCell(withIdentifier: String(describing: PostTableViewCell.self), for: indexPath) as! PostTableViewCell
            cell.post = posts[indexPath.row]
            cell.selectionStyle = .none
            return cell
        }

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.row == 0 else { return }
        let vc = PhotosViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return nil
        } else {
            return profileHeader
        }
    }
}
