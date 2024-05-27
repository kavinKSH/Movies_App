//
//  ReviewersCell.swift
//  Movies_App
//
//  Created by Kavin on 09/05/24.
//

import UIKit

class ReviewersCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var seeAllBtn: UIButton!
    @IBOutlet weak var headLineLabel: UILabel!
    
    static var reuseIdenitifier: String {
        return String(describing: self)
    }
    
    var reviwersVM: ReviwersVM?
    var reviwersArr = [Reviwers]() {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self else {return}
                collectionView.reloadData()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCollectionViewCell()
        headLineLabel.text = "From Top Reviewers"
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setUpCollectionViewCell()
        headLineLabel.text = "From Top Reviewers"
    }
    
    
    @IBAction func seeAllButtonTapped(_ sender: UIButton) {
        guard let reviewersVC = UIApplication.shared.firstKeyWindow?.rootViewController as? UINavigationController else {return}
        reviewersVC.pushViewController(ReviewersVC(reviewer: self.reviwersArr), animated: true)
    }
    
    func setUpCollectionViewCell() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = .init(width: frame.size.width - 30, height: 200)
        flowLayout.sectionInset = .init(top: 0, left: 10, bottom: 0, right: 10)
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 10
        collectionView.collectionViewLayout = flowLayout
        
        collectionView.register(UINib(nibName: ReviwersCollectionCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: ReviwersCollectionCell.reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func setReviewersDatas(_ datas: [Reviwers]) {
        reviwersArr = datas
    }
}

extension ReviewersCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        reviwersArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReviwersCollectionCell.reuseIdentifier, for: indexPath) as? ReviwersCollectionCell else {return UICollectionViewCell()}
        let review = reviwersArr[indexPath.item]
        cell.set(review)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let title = reviwersArr[indexPath.row].author
        guard let reviewersVC = UIApplication.shared.firstKeyWindow?.rootViewController as? UINavigationController else {return}
        reviewersVC.title = title
        reviewersVC.pushViewController(ReviewersVC(reviewer: reviwersArr), animated: true)
    }
    
}
