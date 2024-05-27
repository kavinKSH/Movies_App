//
//  Cell + Extensions.swift
//  Movies_App
//
//  Created by Kavin on 16/05/24.
//

import UIKit

extension UICollectionViewCell {
    
    func showAnimation(){
        alpha = 0.0
        UIView.transition(with: self, duration: 0.2, options: .transitionCrossDissolve, animations: {
            self.alpha = 1.0
        }, completion: nil)
    }
}

extension UITableViewCell {
    func showAnimation(){
        alpha = 0.0
        UIView.transition(with: self, duration: 0.2, options: .transitionCrossDissolve, animations: {
            self.alpha = 1.0
        }, completion: nil)
    }
}



