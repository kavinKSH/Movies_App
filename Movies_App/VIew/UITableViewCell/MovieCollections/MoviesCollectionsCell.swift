//
//  MoviesCollectionsCell.swift
//  Movies_App
//
//  Created by Kavin on 10/05/24.
//

import UIKit

class MoviesCollectionsCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var overViewLabel: UILabel!

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
   
    func setCollectionDatas(_ datas: CollectionData) {
        nameLabel.text = datas.name
        overViewLabel.text = datas.overview
        
        HTTPClient.shared.downloadMoviesImages(url: datas.backdropPathURL) { image in
            DispatchQueue.main.async { [weak self] in
                guard let self else {return}
                backImageView.image = image
            }
        }
    }
    
    func setuplayouts() {
        backImageView.layer.cornerRadius = 10
        backImageView.layer.masksToBounds = true
        backImageView.layer.borderColor = UIColor.white.withAlphaComponent(0.5).cgColor
        backImageView.layer.borderWidth = 1
        backImageView.layer.shadowOpacity = 2
        backImageView.alpha = 0.5
    }
}
