//
//  GetVC + Extensions.swift
//  Movies_App
//
//  Created by Kavin on 09/05/24.
//

import UIKit

extension UIApplication {
    var firstKeyWindow: UIWindow? {
        return UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .filter { $0.activationState == .foregroundActive }
            .first?.keyWindow
    }
}
