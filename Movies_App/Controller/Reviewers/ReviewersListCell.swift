//
//  ReviewersListCell.swift
//  Movies_App
//
//  Created by Kavin on 10/05/24.
//

import UIKit

class ReviewersListCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var reviwerLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var writtenLabel : UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    
    let isoFormatter = ISO8601DateFormatter()

    static var reusableIdentifier: String {
        return String(describing: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setCornerRadious(of: profileImageView, size: profileImageView.frame.height/2)
        containerView.layer.cornerRadius = 10
        containerView.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
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
