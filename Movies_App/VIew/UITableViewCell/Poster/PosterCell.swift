//
//  PosterCell.swift
//  Movies_App
//
//  Created by Kavin on 10/05/24.
//

import UIKit

class PosterCell: UITableViewCell {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var detailLabel: UILabel!
    
    static var reusableIdentifier: String {
        return String(describing: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 20
        self.layer.masksToBounds = true
        detailLabel.bringSubviewToFront(posterImageView)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setCornerRadious(of: posterImageView, size: 5)
        detailLabel.bringSubviewToFront(posterImageView)
    }
    
    func set(_ datas: MoviesDetailData) {
        HTTPClient.shared.downloadMoviesImages(url: datas.backDropPathURL) { image in
            DispatchQueue.main.async { [weak self] in
                guard let self else {return}
                self.posterImageView.image = image
            }
        }
        
        let date = datas.releaseDate ?? ""
        let ratings = String(format: "%.1f", datas.voteAverage ?? 0.0)
        let duration = datas.runtime ?? 0
        let hourToMinutes = minutesToHoursAndMinutes(duration)
        
        detailLabel.text = "| \(date) | ⭐️ \(ratings) | \(hourToMinutes.hours)h \(hourToMinutes.leftMinutes)m |"
    }
    
    func minutesToHoursAndMinutes(_ minutes: Int) -> (hours: Int , leftMinutes: Int) {
        return (minutes / 60, (minutes % 60))
    }
}
