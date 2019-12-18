//
//  UIView+PinToSuperview.swift
//  TatoodoAssignment
//
//  Created by Vitalii Shkliar on 18.12.2019.
//  Copyright © 2019 Vitalii Shkliar. All rights reserved.
//

import UIKit

extension UIView {
    func pinToSuperview(insets: UIEdgeInsets = .zero) {
        guard let superView = superview else {
            return
        }
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: insets.left),
            self.trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: insets.right),
            self.bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: insets.bottom),
            self.topAnchor.constraint(equalTo: superView.topAnchor, constant: insets.top)
        ])
    }
    
    // To Avoid known UIStackView bug (http://www.openradar.me/25087688)
    var isHiddenInStackView: Bool {
        get { isHidden }
        set {
            if isHidden != newValue {
                isHidden = newValue
            }
        }
    }
}
