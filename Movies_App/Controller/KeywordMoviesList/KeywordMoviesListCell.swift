//
//  KeywordMoviesListCell.swift
//  Movies_App
//
//  Created by Kavin on 10/05/24.
//

import UIKit

class KeywordMoviesListCell: UITableViewCell {

    @IBOutlet weak var containerView    : UIView!
    @IBOutlet weak var backImageView    : UIImageView!
    @IBOutlet weak var frontImageview   : UIImageView!
    @IBOutlet weak var titleLabel       : UILabel!
    @IBOutlet weak var ratingLabel      : UILabel!
    @IBOutlet weak var datelabel        : UILabel!
    
    static var reusabkeIdentifier: String {
        return String(describing: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupFrontImageViewBoarders()
        setupBackImageViewBoarders()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setupFrontImageViewBoarders()
        setupBackImageViewBoarders()
    }
    
    func set(_ datas: KeywordMoviesListData) {
        let title = datas.title
        titleLabel.text = title
        let rating = datas.voteAverage ?? 0
        let ratingString = String(format: "%.1f", rating)
        ratingLabel.text = "Rating: ⭐️ \(ratingString)"
        let date = datas.releaseDate?.convertedDisplayFormetForKeywardMovies() ?? ""
        datelabel.text = "Released On: \(date)"
        
        HTTPClient.shared.downloadNowPlayingImages(url: datas.backDropPathURL, completion: { image in
            DispatchQueue.main.async { [weak self] in
                guard let self else {return}
                self.backImageView.image = image
            }
        })
        
        HTTPClient.shared.downloadNowPlayingImages(url: datas.posterPathsURL, completion: { image in
            DispatchQueue.main.async { [weak self] in
                guard let self else {return}
                self.frontImageview.image = image
            }
        })
    }
    
    func setupFrontImageViewBoarders() {
        frontImageview.layer.cornerRadius = 10
        frontImageview.layer.masksToBounds = true
        frontImageview.layer.borderWidth = 1
        frontImageview.layer.borderColor = UIColor.white.withAlphaComponent(0.5).cgColor
        frontImageview.layer.opacity = 2
    }
    
    func setupBackImageViewBoarders() {
        containerView.layer.cornerRadius = 10
        containerView.layer.masksToBounds = true
        backImageView.alpha = 0.3
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.white.withAlphaComponent(0.1).cgColor
        containerView.layer.opacity = 2
    }
}
