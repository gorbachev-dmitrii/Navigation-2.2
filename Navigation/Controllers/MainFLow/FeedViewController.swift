//
//  ViewController.swift
//  Navigation
//
//  Created by Artem Novichkov on 12.09.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit
import StorageService
import SnapKit

final class FeedViewController: UIViewController {
    
    //MARK: Properties
//    var model: MyModel
    var onShowNext: (() -> Void)?
    let realmManager = RealmManager()
    var posts1: [Post] = []
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: String(describing: PostTableViewCell.self))
        tableView.delegate = self
        return tableView
    }()
    
//    init(model: MyModel) {
//        self.model = model
//        super.init(nibName: nil, bundle: nil)
//    }
    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Главная"
        view.addSubview(tableView)
        setupConstraints()
        self.navigationItem.setHidesBackButton(true, animated: true)
        posts1 = realmManager.getAllPosts()
        print(posts1.count)
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.leading.equalTo(self.view.safeAreaLayoutGuide)
            make.trailing.equalTo(self.view.safeAreaLayoutGuide)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
            make.top.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
}

extension FeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .zero
    }
}

extension FeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts1.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PostTableViewCell = tableView.dequeueReusableCell(withIdentifier: String(describing: PostTableViewCell.self), for: indexPath) as! PostTableViewCell
        cell.post1 = posts1[indexPath.row]
        cell.onAddFavTap = {
            print("tapped")
//            self.realmManager.updatePost(post: self.posts1[indexPath.row], isSaved: true)
//            print(posts1[indexPath.row].author)
        }
        return cell
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 350
//    }
    
}
