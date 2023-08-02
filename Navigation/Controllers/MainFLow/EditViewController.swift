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
    private lazy var fullName: CustomTextField = {
        let textField = CustomTextField(placeholder: "Введи ФИО", textColor: .black, bckgColor: .clear, onText: nil)
        return textField
    }()
    
    private lazy var jobName: CustomTextField = {
        let textField = CustomTextField(placeholder: "Введи должность", textColor: .black, bckgColor: .clear, onText: nil)
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(fullName)
//        view.addSubview(jobName)
        setupConstraints()
    }
    
    func setupConstraints() {
        fullName.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
        }
    }
}
