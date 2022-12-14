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
    
    var model: MyModel
    var onShowNext: (() -> Void)?
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [button1, button2])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    
    private lazy var sendWordButton: CustomButton = {
        let button = CustomButton(title: "sendWordButton".localized, titleColor: UIColor.createColor(lightMode: .black, darkMode: .white)) {
            self.sendWord()
        }
        button.backgroundColor = .cyan
        return button
    }()
    
    private lazy var button1: CustomButton = {
        let button = CustomButton(title: "feedVCFirstButton".localized, titleColor: .systemBlue) { [weak self] in
            self?.onShowNext?()
        }
        return button
    }()
    
    private lazy var button2: CustomButton = {
        let button = CustomButton(title: "feedVCSecondButton".localized, titleColor: .systemBlue) { [weak self] in
            self?.onShowNext?()
        }
        return button
    }()
    
    private lazy var textField: CustomTextField = {
        let field = CustomTextField(
            placeholder: "feedVCPlaceholder".localized,
            textColor: .blue,
            bckgColor: UIColor.createColor(lightMode: .black, darkMode: .white)) { (text) in
            print(text)
        }
        return field
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.backgroundColor = .brown
        label.text = "feedCheckLabel".localized
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
        view.addSubviews(views: [sendWordButton, stackView, textField, label])
        view.disableAutoresizingMask(views: [sendWordButton, stackView, textField, label])
        setupConstraints()
        view.backgroundColor = .white
    }
    
    private func setupConstraints() {
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
