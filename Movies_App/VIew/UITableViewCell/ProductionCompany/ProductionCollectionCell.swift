//
//  ProductionCollectionCell.swift
//  Movies_App
//
//  Created by Kavin on 10/05/24.
//

import UIKit

class ProductionCollectionCell: UICollectionViewCell {

    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    static var reusableIdentifier: String {
        return String(describing: self)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setCornerRadious(of: containerView, size: 10)
    }
}
