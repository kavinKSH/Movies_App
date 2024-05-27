//
//  KeywordCollectionCell.swift
//  Movies_App
//
//  Created by Kavin on 10/05/24.
//

import UIKit

class KeywordCollectionCell: UICollectionViewCell {
    
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var keywordLabel: UILabel!
    
    static var reusableIdentifier: String {
        return String(describing: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setCornerRadious(of: containerView, size: 10)
    }
}
