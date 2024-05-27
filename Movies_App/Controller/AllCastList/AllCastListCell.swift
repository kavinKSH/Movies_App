//
//  AllCastListCell.swift
//  Movies_App
//
//  Created by Kavin on 10/05/24.
//

import UIKit

class AllCastListCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var characterLabel: UILabel!
    
    static var reusableIdentifier: String {
        return String(describing: self)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setCornerRadious()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setCornerRadious()
    }
    
    private func setCornerRadious() {
        profileImageView.layer.cornerRadius = 10
        profileImageView.layer.masksToBounds = true
    }
    
    func set(_ datas: Cast) {
        nameLabel.text = datas.name
        characterLabel.text = datas.character
        
        HTTPClient.shared.downloadMoviesImages(url: datas.profilePathURL) { image in
            DispatchQueue.main.async { [weak self] in
                guard let self else{return}
                profileImageView.image = image
            }
        }
    }
}
