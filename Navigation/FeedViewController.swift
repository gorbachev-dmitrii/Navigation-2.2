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
    
    let post: Post = Post(title: "Пост")
    
    private lazy var stackView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [button1, button2])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var button: MyButton = {
        let button = MyButton(title: "button", titleColor: .white) {
            print("click")
        }
        button.backgroundColor = .black
        return button
    }()
    
    private lazy var button1: MyButton = {
        let button = MyButton(title: "Button", titleColor: .systemBlue) {
            self.moveToPostVC()
        }
        return button
    }()
    
    private lazy var button2: MyButton = {
        let button = MyButton(title: "Button", titleColor: .systemBlue) {
            self.moveToPostVC()
        }
        return button
    }()
    
    private lazy var textField: UITextField = {
       let field = UITextField()
    }()
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        print(type(of: self), #function)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        print(type(of: self), #function)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(type(of: self), #function)
        view.addSubview(button)
        view.addSubview(stackView)
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(type(of: self), #function)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(type(of: self), #function)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print(type(of: self), #function)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print(type(of: self), #function)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print(type(of: self), #function)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print(type(of: self), #function)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "post" else {
            return
        }
        guard let postViewController = segue.destination as? PostViewController else {
            return
        }
        postViewController.post = post
    }
    
    func setupConstraints() {
        button.snp.makeConstraints { (make) in
            make.bottom.equalTo(-60)
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
        }
        stackView.snp.makeConstraints { (make) in
            make.leading.top.equalTo(70)
        }
    }
    
    private func moveToPostVC() {
        let vc = PostViewController()
        navigationController?.pushViewController(vc, animated: true)
        vc.post = post
    }
}
