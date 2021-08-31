//
//  InfoViewController.swift
//  Navigation
//
//  Created by Artem Novichkov on 12.09.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit
import SnapKit

class InfoViewController: UIViewController {
    
    var residents: [Resident] = []
    
    private lazy var taskTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Some text"
        label.textColor = .green
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    private lazy var planetInfo: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Some text 2"
        label.textColor = .red
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(taskTitle)
        view.addSubview(planetInfo)
        view.addSubview(tableView)
        setupConstraints()
        
        NetworkManager.getTask(url: URL(string: Constants.taskUrl)!) { string in
            DispatchQueue.main.async {
                self.taskTitle.text = string
            }
        }
        
        NetworkManager.getPlanet(url: URL(string: Constants.planetUrl)!) { (name, period) in
            DispatchQueue.main.async {
                self.planetInfo.text = "orbital period of \(name) is \(period)"
            }
        } secondClosure: { (name) in
            self.residents.append(name)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }
    
    
    private func setupConstraints() {
        taskTitle.snp.makeConstraints { (make) in
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.centerX.equalTo(view.center)
            make.top.equalTo(self.view.safeAreaLayoutGuide).inset(16)
        }
        
        planetInfo.snp.makeConstraints { (make) in
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.centerX.equalTo(view.center)
            make.top.equalTo(taskTitle.snp.bottom).offset(20)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.leading.equalTo(self.view.safeAreaLayoutGuide)
            make.trailing.equalTo(self.view.safeAreaLayoutGuide)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(100)
        }
    }
}

// MARK: Extensions

extension InfoViewController: UITableViewDelegate {
    
}

extension InfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return residents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = residents[indexPath.row].name
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
}
