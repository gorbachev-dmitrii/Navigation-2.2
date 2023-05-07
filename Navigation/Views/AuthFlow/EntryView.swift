//
//  EntryView.swift
//  Navigation
//
//  Created by Dima Gorbachev on 07.05.2023.
//  Copyright © 2023 Artem Novichkov. All rights reserved.
//

import UIKit
import SnapKit

final class EntryView: UIView {
//    private let logoView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.image = UIImage(named: "logo")
//        return imageView
//    }()
    var onShowNext: ((_: String) -> Void)?
    lazy var registerButton: CustomButton = {
        let button = CustomButton(title: "registerButton".localized.uppercased(), titleColor: .white) {
            self.onShowNext?("signUp")
            print("111111")
        }
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        button.backgroundColor = UIColor(named: "CustomBlack")
        button.layer.cornerRadius = 10
        return button
    }()
    
    private lazy var haveAccountButton: CustomButton = {
        let button = CustomButton(title: "haveAccButton".localized, titleColor: .black) {
//            self.loginButtonTapped()
        }
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return button
    }()
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.addSubviews(views: [haveAccountButton,registerButton])
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        registerButton.snp.makeConstraints { make in
            make.leading.equalTo(55)
            make.trailing.equalTo(-55)
            make.bottom.equalTo(haveAccountButton.snp.top).inset(-30)
        }
        haveAccountButton.snp.makeConstraints { make in
            make.leading.equalTo(128)
            make.trailing.equalTo(-128)
            make.bottom.equalTo(-150)
        }
    }
}
