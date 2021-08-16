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
    var model: MyModel
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [button1, button2])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var sendWordButton: MyButton = {
        let button = MyButton(title: "button", titleColor: .white) {
            self.sendWord()
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
    
    private lazy var textField: MyTextField = {
        let field = MyTextField(placeholder: "input", textColor: .blue, bckgColor: .white) { (text) in
            print(text)
        }
        return field
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.backgroundColor = .brown
        label.text = "Some text"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(model: MyModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(type(of: self), #function)
        view.addSubview(sendWordButton)
        view.addSubview(stackView)
        view.addSubview(textField)
        view.addSubview(label)
        setupConstraints()
        view.backgroundColor = .cyan
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
        sendWordButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(-100)
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
        }
        textField.snp.makeConstraints { (make) in
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.bottom.equalTo(sendWordButton.snp.top).inset(-50)
        }
        stackView.snp.makeConstraints { (make) in
            make.centerX.equalTo(view.center.x)
            make.centerY.equalTo(view.center.y)
        }
        
        label.snp.makeConstraints { (make) in
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.top.equalTo(100)
        }
    }
    
    private func moveToPostVC() {
        let vc = PostViewController()
        navigationController?.pushViewController(vc, animated: true)
        vc.post = post
    }
    
    private func sendWord() {
        
        if let text = textField.text, !text.isEmpty {
            model.checkWord(word: text) { result in
                if result {
                    self.label.backgroundColor = .green
                } else {
                    self.label.backgroundColor = .red
                }
            }
        } else {
            print("value is nil or empty")
        }
    }
}
