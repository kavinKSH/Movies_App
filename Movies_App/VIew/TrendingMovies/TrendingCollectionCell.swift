//
//  TrendingCollectionCell.swift
//  Movies_App
//
//  Created by Kavin on 10/05/24.
//

import UIKit

class TrendingCollectionCell: UICollectionViewCell {

    @IBOutlet weak var imageContainerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var starRatingImageView: UIImageView!
    
    static var reusableIdentifireforTrending: String {
        return String(describing: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.white.withAlphaComponent(0.5).cgColor
    }
    
    func set(_ datas: TrendingMoviesData) {
        let title = datas.title ?? datas.name
        movieNameLabel.text = title
        let rating = datas.voteAverage ?? 0
        ratingLabel.text = String(format: "%.1f", rating)
        ratingImageViewRatings(of: rating)
        
        HTTPClient.shared.downloadNowPlayingImages(url: datas.posterPathURL, completion: { image in
            DispatchQueue.main.async { [weak self] in
                guard let self else {return}
                self.imageView.image = image
            }
        })
    }
    
    func ratingImageViewRatings(of movieRatings: Double){
        if movieRatings > 8.0 {
            starRatingImageView.image = UIImage(systemName: "star.fill")
        } else if movieRatings < 8.0 {
            starRatingImageView.image = UIImage(systemName: "star.leadinghalf.filled")
        }
    }
}
