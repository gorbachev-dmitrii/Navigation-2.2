//
//  EditViewController.swift
//  Navigation
//
//  Created by Dima Gorbachev on 29.06.2023.
//  Copyright © 2023 Artem Novichkov. All rights reserved.
//

import UIKit

final class EditViewController: UIViewController {
    private lazy var jobName: CustomTextField = {
        let textField = CustomTextField(placeholder: "", textColor: .black, bckgColor: .clear, onText: nil)
        return textField
    }()
}
