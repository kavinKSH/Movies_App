//
//  PartHeader.swift
//  Movies_App
//
//  Created by Kavin on 10/05/24.
//

import UIKit

class PartHeader: UITableViewHeaderFooterView {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var frontImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var overViewLabel: UILabel!
    
    static var reusableIdentifier: String {
        return String(describing: self)
    }
    
    func set(_ datas: CollectionData) {
        nameLabel.text = "Part Of the \(datas.name ?? "")"
        overViewLabel.text = datas.overview
        
        HTTPClient.shared.downloadMoviesImages(url: datas.backdropPathURL) { image in
            DispatchQueue.main.async { [weak self] in
                guard let self else {return}
                backImageView.image = image
                backImageView.alpha = 0.5
            }
        }
        
        HTTPClient.shared.downloadMoviesImages(url: datas.posterPathURL) { image in
            DispatchQueue.main.async { [weak self] in
                guard let self else {return}
                frontImageView.image = image
            }
        }
    }
}
