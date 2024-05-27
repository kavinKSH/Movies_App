//
//  SearchCell.swift
//  Movies_App
//
//  Created by Kavin on 10/05/24.
//

import UIKit

class SearchCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var frontImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    static var reusableIdentifier: String {
        return String(describing: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setuplayouts()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setuplayouts()
    }
    
    func set(_ datas: SearchMovies) {
        nameLabel.text = datas.originalTitle ?? datas.title
        let round = String(format: "%.2f", datas.voteAverage ?? 0)
        ratingLabel.text = "Rating: ⭐️ \(round)"
        dateLabel.text = "Released On: \(datas.releaseDate ?? "")"
        
        HTTPClient.shared.downloadMoviesImages(url: datas.backdropPathURL) { image in
            DispatchQueue.main.async { [weak self] in
                guard let self else {return}
                backImageView.image = image
            }
        }
        
        HTTPClient.shared.downloadMoviesImages(url: datas.posterPathURL) { image in
            DispatchQueue.main.async { [weak self] in
                guard let self else {return}
                frontImageView.image = image
            }
        }
    }
    
    func setuplayouts() {
        frontImageView.layer.cornerRadius = 10
        frontImageView.layer.masksToBounds = true
        frontImageView.layer.borderColor = UIColor.white.withAlphaComponent(0.3).cgColor
        frontImageView.layer.borderWidth = 1
        frontImageView.layer.shadowOpacity = 0.1
        containerView.layer.cornerRadius = 10
        containerView.layer.masksToBounds = true
        backImageView.alpha = 0.3
    }
}
