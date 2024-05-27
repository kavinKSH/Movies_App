//
//  UIView + Extensions.swift
//  Movies_App
//
//  Created by Kavin on 09/05/24.
//

import UIKit

extension UIView {
    func setCornerRadious(of view: UIView, size: CGFloat) {
        view.layer.cornerRadius = size
        view.layer.masksToBounds = true
    }
}


