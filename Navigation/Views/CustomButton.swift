//
//  MyButton.swift
//  Navigation
//
//  Created by Dima Gorbachev on 05.07.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class CustomButton: UIButton {
    
    var onTap: (() -> Void)?
    
    init(title:String, titleColor: UIColor, onTap: (() -> Void)?) {
        super.init(frame: .zero)
        self.onTap = onTap
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func buttonTapped() {
        onTap?()
    }
    // нагло скопипасчено со StackOverflow)))
    override var isHighlighted: Bool {
        get { return super.isHighlighted }
        set {
            guard newValue != isHighlighted else { return }
            
            if newValue == true {
                titleLabel?.alpha = 0.25
            } else {
                UIView.animate(withDuration: 0.25) {
                    self.titleLabel?.alpha = 1
                }
                super.isHighlighted = newValue
            }
            
            super.isHighlighted = newValue
        }
    }
    
}
