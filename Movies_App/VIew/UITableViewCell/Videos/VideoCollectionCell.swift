//
//  VideoCollectionCell.swift
//  Movies_App
//
//  Created by Kavin on 10/05/24.
//

import UIKit
import YouTubeiOSPlayerHelper

class VideoCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var playerView: YTPlayerView!
    
    static var reuseIdenitifier: String {
        return String(describing: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func set(_ datas: Videos) {
        playerView.load(withVideoId: datas.key ?? "")
    }
}
