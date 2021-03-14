//
//  UIView + Support Functions.swift
//  Navigation
//
//  Created by Dima Gorbachev on 14.03.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

extension UIView {
    
    public func disableAutoresizingMask(views: [UIView]) {
        views.forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
        })
    }
    public func addSubviews(views: [UIView]) {
        views.forEach({
            self.addSubview($0)
        })
    }
}
