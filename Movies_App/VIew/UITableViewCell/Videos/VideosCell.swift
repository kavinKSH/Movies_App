//
//  VideosCell.swift
//  Movies_App
//
//  Created by Kavin on 10/05/24.
//

import UIKit

class VideosCell: UITableViewCell {
    
    @IBOutlet weak var headLineLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    static var reusableIdentifier: String {
        return String(describing: self)
    }
    
    var videoArr = [Videos]() {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self else {return}
                headLineLabel.text = "Watch Movie Clips and Trailers"
                collectionView.reloadData()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCollectionViewCell()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setUpCollectionViewCell()
    }
    
    func setUpCollectionViewCell() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = .init(width: frame.width, height: 240)
        flowLayout.sectionInset = .init(top: 0, left: 10, bottom: 0, right: 10)
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 10
        collectionView.collectionViewLayout = flowLayout
        
        collectionView.register(UINib(nibName: VideoCollectionCell.reuseIdenitifier, bundle: nil), forCellWithReuseIdentifier: VideoCollectionCell.reuseIdenitifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func setVideosData(_ videoDatas: [Videos]) {
        videoArr = videoDatas
    }
}

extension VideosCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        videoArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoCollectionCell.reuseIdenitifier, for: indexPath) as? VideoCollectionCell else {return UICollectionViewCell()}
        let video = videoArr[indexPath.item]
        cell.set(video)
        return cell
    }
}

