//
//  EditViewController.swift
//  Navigation
//
//  Created by Dima Gorbachev on 29.06.2023.
//  Copyright © 2023 Artem Novichkov. All rights reserved.
//

import UIKit
import SnapKit

final class EditViewController: UIViewController {
    
    let userService: UserService
    let realmManager = RealmManager()
    
    var onSaveButtonTapped: (() -> Void)?
    
    
    private lazy var fullName: CustomTextField = {
        let textField = CustomTextField(placeholder: "Введи ФИО", textColor: .black, bckgColor: .clear, onText: nil)
        return textField
    }()
    
    private lazy var jobName: CustomTextField = {
        let textField = CustomTextField(placeholder: "Введи должность", textColor: .black, bckgColor: .clear, onText: nil)
        return textField
    }()
    
    private lazy var saveChanges: CustomButton = {
        let button = CustomButton(title: "", titleColor: .white) {
            print("save")
            self.realmManager.updateUser(user: self.userService.user!, jobName: self.jobName.text, fullname: self.fullName.text
            )
            self.onSaveButtonTapped?()
            
        }
        button.setImage(UIImage(systemName: "checkmark"), for: .normal)
        return button
    }()
    
    init(userService: UserService) {
        self.userService = userService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(fullName)
        view.addSubview(jobName)
        view.backgroundColor = .white
        setupConstraints()
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: saveChanges)
    }
    
//    private func update() {
//        fullName.text
//        jobName.text
//    }
    
    private func setupConstraints() {
        fullName.snp.makeConstraints { make in
            make.leading.trailing.top.equalTo(self.view.safeAreaLayoutGuide).offset(20).inset(20)
        }
        
        jobName.snp.makeConstraints { make in
            make.leading.trailing.equalTo(fullName)
            make.top.equalTo(fullName.snp_bottomMargin).offset(20)
        }
    }
}
