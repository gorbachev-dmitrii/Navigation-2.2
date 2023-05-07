//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Dima Gorbachev on 16.01.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit
import StorageService
import Firebase
import SnapKit

class ProfileViewController: UIViewController {
    // MARK: Properties
    private var statusText: String = ""
    let profileHeader = ProfileHeaderView()
    //let userService: UserService
    let user: RealmUser
    
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
    
    //var profileViewModel: ProfileViewModel
    // MARK: Lifecycle
    init(user: RealmUser) {
        self.user = user
        super.init(nibName: nil, bundle: nil)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //    init(viewModel: ProfileViewModel, userService: UserService, username: String) {
    //        self.userService = userService
    //        profileHeader.fullNameLabel.text = userService.getUser(username: username).name
    //        profileHeader.statusLabel.text = userService.getUser(username: username).status
    //        profileHeader.avatarImageView.image = UIImage(named: userService.getUser(username: username).avatar)
    //        print(userService.getUser(username: username).name)
    //        self.profileViewModel = viewModel
    //        super.init(nibName: nil, bundle: nil)
    //    }
    //    init(viewModel: ProfileViewModel) {
    //        self.profileViewModel = viewModel
    //        super.init(nibName: nil, bundle: nil)
    //    }
    
    //    required init?(coder: NSCoder) {
    //        fatalError("init(coder:) has not been implemented")
    //    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(user.login)
        //       let user = profileViewModel.createUser()
        //        profileHeader.fullNameLabel.text = user.name
        //        profileHeader.statusLabel.text = user.status
        //        profileHeader.avatarImageView.image = UIImage(named: user.avatar)
        
#if DEBUG
        view.backgroundColor = UIColor.createColor(lightMode: .black, darkMode: .white)
#elseif RELEASE
        view.backgroundColor = .green
#endif
        
        profileHeader.statusTextField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        profileHeader.addSubview(blurView)
        view.addSubview(tableView)
        profileHeader.bringSubviewToFront(profileHeader.avatarImageView)
        blurView.addSubview(cancelButton)
        setupConstraints()
        cancelButton.addTarget(self, action: #selector(cancelPressed), for: .touchUpInside)
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        profileHeader.avatarImageView.addGestureRecognizer(tapRecognizer)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.isHidden = true
    }
    // MARK: Actions
    @objc func cancelPressed() {
        
        UIView.animateKeyframes(withDuration: 0.8,
                                delay: 0,
                                options: [],
                                animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.3 / 0.8, animations: {
                self.cancelButton.alpha = 0
            })
            UIView.addKeyframe(withRelativeStartTime: 0.5 / 0.8, relativeDuration: 0.5 / 0.8, animations: {
                self.blurView.alpha = 0
                self.profileHeader.avatarImageView.transform = CGAffineTransform.identity
            })
        },
                                completion: nil)
    }
    
    @objc func imageViewTapped() {
        UIView.animateKeyframes(withDuration: 0.8,
                                delay: 0,
                                options: [],
                                animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5 / 0.8, animations: {
                self.blurView.alpha = 0.75
                // смещаем frame по x и y
                let positionTransform = CGAffineTransform(translationX: (self.view.frame.width / 2) - (self.profileHeader.avatarImageView.frame.width / 2) - 16,y: (self.view.frame.height / 2) - self.profileHeader.avatarImageView.frame.height)
                let x = self.view.frame.width / self.profileHeader.avatarImageView.frame.width
                let sizeTransform = CGAffineTransform(scaleX: x, y: x)
                let transform = sizeTransform.concatenating(positionTransform)
                self.profileHeader.avatarImageView.transform = transform
            })
            UIView.addKeyframe(withRelativeStartTime: 0.5 / 0.8, relativeDuration: 0.3 / 0.8, animations: {
                self.cancelButton.alpha = 1
            })
        },
                                completion: nil)}
    
    @objc func statusTextChanged(_ textField: UITextField) {
        if let temp = profileHeader.statusTextField.text {
            statusText = temp
        }
    }
    // MARK: Constraints
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        blurView.snp.makeConstraints { make in
            make.leading.equalTo(profileHeader.snp.leading)
            make.trailing.equalTo(profileHeader.snp.trailing)
            make.height.equalToSuperview()
        }
        cancelButton.snp.makeConstraints { make in
            make.trailing.equalTo(blurView.snp.trailing).inset(10)
            make.top.equalTo(blurView.snp.top).inset(10)
        }
    }
}
// MARK: UITableViewDelegate
extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 220
        } else {
            return 40
        }
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .zero
    }
}
// MARK: UITableViewDataSource
extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return posts.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
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
        //        profileViewModel.onTapShowNextModule()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 0 {
            return profileHeader
        } else {
            return nil
        }
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section:Int) -> String? {
        switch section {
        case 0: return "1 section"
        case 1: return "sectionTitle".localized
        default: return ""
        }
    }
}
