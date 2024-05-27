//
//  NowPlayingCell.swift
//  Movies_App
//
//  Created by Kavin on 11/05/24.
//

import UIKit

class NowPlayingCell: UICollectionViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var frontImageView: UIImageView!
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var voteLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var leftView: UIView!
    @IBOutlet weak var rightView: UIView!
    @IBOutlet weak var blurView: UIView!
    
    var client: HTTPClient?
    
    static var reusableIdentifier: String {
        return String(describing: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backImageView.alpha = 0.5
        frontImageView.layer.cornerRadius = 10
        frontImageView.layer.masksToBounds = true
        frontImageView.layer.borderColor = UIColor.secondaryLabel.withAlphaComponent(1).cgColor
        frontImageView.layer.opacity = 5
        frontImageView.layer.borderWidth = 1
        configureUI()
    }
    
    func configureUI() {
        leftView.layer.cornerRadius = 15
        leftView.layer.masksToBounds = true
        leftView.layer.opacity = 2
        leftView.layer.borderColor = UIColor.secondaryLabel.withAlphaComponent(0.5).cgColor
        leftView.layer.borderWidth = 0.2
        rightView.layer.cornerRadius = 15
        rightView.layer.masksToBounds = true
        rightView.layer.borderColor = UIColor.secondaryLabel.withAlphaComponent(0.5).cgColor
        rightView.layer.borderWidth = 0.2
        rightView.layer.opacity = 2
        blurView.alpha = 0.8
    }
    
    func setCellDatas(_ datas: NowPlayingMovies) {
        let title = datas.title ?? ""
        let rating = String(format: "%.1f", datas.voteAverage ?? 0.0)
        nameLabel.text = title
        ratingLabel.text = "✔︎ Ratings \(rating)✰"
        voteLabel.text = "✔︎ Votes \(datas.voteCount ?? 0)"
        
        HTTPClient.shared.downloadNowPlayingImages(url: datas.posterPathsURLString) { image in
            DispatchQueue.main.async { [weak self] in
                guard let self else {return}
                frontImageView.image = image
            }
        }
        
        HTTPClient.shared.downloadNowPlayingImages(url: datas.backDropPathURLString) { image in
            DispatchQueue.main.async { [weak self] in
                guard let self else {return}
                backImageView.image = image
            }
        }
    }
}
