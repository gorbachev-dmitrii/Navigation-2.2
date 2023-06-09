//
//  FavoritesViewController.swift
//  Navigation
//
//  Created by Artem Novichkov on 12.09.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit
import StorageService
import SnapKit

class FavoritesViewController: UIViewController {
    
    var post: Post?
    private var favoritePosts = [PostData]()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PostTableViewCell_old.self, forCellReuseIdentifier: String(describing: PostTableViewCell_old.self))
        return tableView
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(tableView)
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        reloadCoreDataFilesByFetch()
        if favoritePosts.count == 0 {
            createEmptyFavListAlert()
        }
    }
    
    private func reloadCoreDataFilesByFetch() {
        self.favoritePosts = CoreDataManager.shared.fetchFavourites()
        tableView.reloadData()
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.leading.equalTo(self.view.safeAreaLayoutGuide)
            make.trailing.equalTo(self.view.safeAreaLayoutGuide)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
            make.top.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
    private func createEmptyFavListAlert() {
        let alert = UIAlertController(title: "postAlertTitle".localized, message: "postAlertMessage".localized, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "postAlertAction".localized, style: .default, handler: { _ in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritePosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell: PostTableViewCell_old = tableView.dequeueReusableCell(withIdentifier: String(describing: PostTableViewCell_old.self), for: indexPath) as! PostTableViewCell_old
        cell.selectionStyle = .default
        cell.post = favoritePosts[indexPath.row]
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
}
