//
//  PostViewController.swift
//  Navigation
//
//  Created by Artem Novichkov on 12.09.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit
import UIKit
import StorageService
import SnapKit

class PostViewController: UIViewController {
    
    var post: Post?
    
    private lazy var button: MyButton = {
        let btn = MyButton(title: "to InfoVC", titleColor: .black) {
            self.goToInfo()
        }
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = post?.title
        view.backgroundColor = .green
        view.addSubview(button)
        setupConstraints()
    }
    
    func goToInfo() {
        let vc = InfoViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setupConstraints() {
        button.snp.makeConstraints { (make) in
            make.centerX.centerY.equalTo(view.center)
        }
    }
}

