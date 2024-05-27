//
//  ReviewersCollectionCell.swift
//  Movies_App
//
//  Created by Kavin on 09/05/24.
//

import UIKit

class ReviwersCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var reviwerLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var writtenLabel : UILabel!
    @IBOutlet weak var commentsLabel: UILabel!

    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setCornerRadious(of: profileImageView, size: profileImageView.frame.height/2)
        containerView.layer.cornerRadius = 10
        containerView.layer.masksToBounds = true
    }
    
    func set(_ reviewers: Reviwers) {
        let authorName = reviewers.author ?? reviewers.authorDetails?.name
        reviwerLabel.animatedTextWithTitle(title: "A review by: ", for: authorName)
        let ratingDoubleValue = reviewers.authorDetails?.rating
        let rating = String(format: "%.1f", ratingDoubleValue ?? "")
        ratingLabel.animatedTextWithTitle(title: "Rating: ", for: rating)
        writtenLabel.animatedTextWithTitle(title: "Written by: ", for: "\(authorName ?? ""), \(reviewers.updatedAt?.convertedDisplayFormet() ?? "")")
        commentsLabel.animatedText(for: reviewers.content)

        HTTPClient.shared.downloadMoviesImages(url: reviewers.authorDetails?.avatarPathURL) { image in
            DispatchQueue.main.async { [weak self] in
                guard let self else {return}
                profileImageView.image = image
            }
        }
    }
}
