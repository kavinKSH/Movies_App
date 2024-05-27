//
//  SimilerCollectionCell.swift
//  Movies_App
//
//  Created by Kavin on 09/05/24.
//

import UIKit

class SimilerCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var similerImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    static var reusableIdentifier: String {
        return String(describing: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 20
        self.layer.masksToBounds = true
    }
    
    func set(_ datas: Similer) {
        titleLabel.text = datas.title
        
        HTTPClient.shared.downloadMoviesImages(url: datas.backDropPathURL) { image in
            DispatchQueue.main.async { [weak self] in
                guard let self else {return}
                self.similerImageView.image = image
            }
        }
    }
}
