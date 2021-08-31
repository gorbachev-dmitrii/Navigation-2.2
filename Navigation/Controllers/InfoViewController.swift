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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(taskTitle)
        view.addSubview(planetInfo)
        setupConstraints()

//        NetworkManager.getTask(url: URL(string: Constants.taskUrl)!) { string in
//            DispatchQueue.main.async {
//                self.taskTitle.text = string
//            }
//        }
        
        NetworkManager.getPlanet(url: URL(string: Constants.planetUrl)!) { (name, period) in
            DispatchQueue.main.async {
                self.planetInfo.text = "orbital period of \(name) is \(period)"
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
    }
}
