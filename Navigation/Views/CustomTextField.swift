//
//  MyTextField.swift
//  Navigation
//
//  Created by Dima Gorbachev on 08.07.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {
    
    var onText: ((String) -> Void)?
    
    init(placeholder: String, textColor: UIColor, bckgColor: UIColor, onText: ((String) -> Void)?) {
        super.init(frame: .zero)
        self.onText = onText
        self.placeholder = placeholder
        self.textColor = textColor
        self.backgroundColor = bckgColor
        self.layer.borderColor = UIColor(named: "CustomBlack")?.cgColor
        self.layer.borderWidth = 0.5
        self.layer.cornerRadius = 10
        self.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        self.autocapitalizationType = .none
        translatesAutoresizingMaskIntoConstraints = false
        addTarget(self, action: #selector(textPrinted), for: .editingChanged)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func textPrinted() {
        guard let text = text else { return }
        onText?(text)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4))
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4))
    }
    
}
