//
//  TVCollectionCell.swift
//  Movies_App
//
//  Created by Kavin on 10/05/24.
//

import UIKit

class TVCollectionCell: UICollectionViewCell {

    @IBOutlet weak var imageContainerView   : UIView!
    @IBOutlet weak var titleView            : UIView!
    @IBOutlet weak var frontImageView       : UIImageView!
    @IBOutlet weak var ratingImageView      : UIImageView!
    @IBOutlet weak var movieNameLabel       : UILabel!
    @IBOutlet weak var ratingLabel          : UILabel!
    
    static var reusableIdentifier: String {
        return String(describing: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.white.withAlphaComponent(0.5).cgColor
    }
    
    func set(_ datas: TVDatas) {
        let title = datas.name ?? datas.originalName
        movieNameLabel.text = title
        let rating = datas.voteAverage ?? 0
        ratingLabel.text = String(format: "%.1f", rating)
        ratingImageViewRatings(of: rating)
        
        HTTPClient.shared.downloadNowPlayingImages(url: datas.posterPathsURL, completion: { image in
            DispatchQueue.main.async { [weak self] in
                guard let self else {return}
                self.frontImageView.image = image
            }
        })
    }
    
    func ratingImageViewRatings(of movieRatings: Double){
        if movieRatings > 8.0 {
            ratingImageView.image = UIImage(systemName: "star.fill")
            ratingImageView.tintColor = .systemYellow
        } else if movieRatings < 8.0 {
            ratingImageView.image = UIImage(systemName: "star.leadinghalf.filled")
            ratingImageView.tintColor = .systemYellow
        }
    }
}
