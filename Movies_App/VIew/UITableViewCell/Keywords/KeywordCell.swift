//
//  KeywordCell.swift
//  Movies_App
//
//  Created by Kavin on 10/05/24.
//

import UIKit

class KeywordCell: UITableViewCell {
    
    @IBOutlet weak var headLineLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var keywordArr = [Keywords]() {
        didSet {
            DispatchQueue.main.async {[weak self] in
                guard let self else{return}
                collectionView.reloadData()
            }
        }
    }
    
    static var reusableIdentifier: String {
        return String(describing: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCollectionViewCell()
        headLineLabel.text = "Keywords"
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setUpCollectionViewCell()
        headLineLabel.text = "Keywords"
    }
    
    func setKeywardsData(_ datas: [Keywords]) {
        self.keywordArr = datas
    }
    
    func setUpCollectionViewCell() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = .init(top: 0, left: 0, bottom: 0, right: 10)
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.scrollDirection = .horizontal
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        collectionView.collectionViewLayout = flowLayout

        collectionView.register(UINib(nibName: KeywordCollectionCell.reusableIdentifier, bundle: nil), forCellWithReuseIdentifier: KeywordCollectionCell.reusableIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension KeywordCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return keywordArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KeywordCollectionCell.reusableIdentifier, for: indexPath) as? KeywordCollectionCell else {return UICollectionViewCell()}
        let name = keywordArr[indexPath.item].name
        cell.keywordLabel.text = name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let keywordId = keywordArr[indexPath.row].id ?? 0
        let title = keywordArr[indexPath.row].name
        
        guard let keywordMoviesListVC = UIApplication.shared.firstKeyWindow?.rootViewController as? UINavigationController else {return}
        let keywordVC = KeywordMoviesListVC(keywordID: keywordId)
        keywordVC.keywordName = title
        keywordMoviesListVC.pushViewController(keywordVC, animated: true)
        
    }
}


