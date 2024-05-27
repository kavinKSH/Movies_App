//
//  TopCastCollectionCell.swift
//  Movies_App
//
//  Created by Kavin on 10/05/24.
//

import UIKit

class TopCastCollectionCell: UICollectionViewCell {

    @IBOutlet weak var castImageView: UIImageView!
    
    static var reusableIdentifier: String {
        return String(describing: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        castImageView.layer.cornerRadius = castImageView.frame.height / 2
        castImageView.layer.masksToBounds = true
    }
    
    func set(_ castData: Cast) {
        HTTPClient.shared.downloadMoviesImages(url: castData.profilePathURL) { image in
            DispatchQueue.main.async {[weak self] in
                guard let self else {return}
                castImageView.image = image
            }
        }
    }
}
