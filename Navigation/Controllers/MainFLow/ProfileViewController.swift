//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Dima Gorbachev on 16.01.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit
import StorageService
import SnapKit

class ProfileViewController: UIViewController {
    // MARK: Properties
    private var statusText: String = ""
    let profileHeader = ProfileHeaderView()
    let user: RealmUser
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.register(PostTableViewCell_old.self, forCellReuseIdentifier: String(describing: PostTableViewCell_old.self))
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: String(describing: PhotosTableViewCell.self))
        tableView.delegate = self
//        tableView.backgroundColor = UIColor(named: "CustomMilky")
        tableView.backgroundColor = .white
        return tableView
    }()
    
    // MARK: Lifecycle
    init(user: RealmUser) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(user.login)
        profileHeader.statusTextField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        view.addSubview(tableView)
        setupConstraints()
        self.navigationItem.title = user.login
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
//        navigationController?.navigationBar.isHidden = true
    }
    // MARK: Actions
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
            let cell: PostTableViewCell_old = tableView.dequeueReusableCell(withIdentifier: String(describing: PostTableViewCell_old.self), for: indexPath) as! PostTableViewCell_old
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
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
      if let headerView = view as? UITableViewHeaderFooterView {
//          headerView.contentView.backgroundColor = .white
//          headerView.backgroundView?.backgroundColor = .black
          headerView.textLabel?.textColor = UIColor(named: "CustomOrange")
      }
  }
}
