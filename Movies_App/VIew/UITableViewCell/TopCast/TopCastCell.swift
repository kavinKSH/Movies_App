//
//  TopCastCell.swift
//  Movies_App
//
//  Created by Kavin on 10/05/24.
//

import UIKit

class TopCastCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var topCastLabel: UILabel!
    @IBOutlet weak var seeAllBtn: UIButton!
    
    var movieDetailVM: MovieDetailVM?
    var castArr = [Cast]() {
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
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setUpCollectionViewCell()
    }
    
    func setCastDatas(_ datas: [Cast]) {
        self.castArr = datas
    }
    
    @IBAction func seeAllButtontapped(_ sender: UIButton) {
        guard let allCastListVC = UIApplication.shared.firstKeyWindow?.rootViewController as? UINavigationController else {return}
        allCastListVC.pushViewController(AllCastListVC(castArr: self.castArr), animated: true)
    }

    func setUpCollectionViewCell() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 100, height: 100)
        flowLayout.sectionInset = .init(top: 0, left: 0, bottom: 0, right: 10)
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = flowLayout
        
        collectionView.register(UINib(nibName: TopCastCollectionCell.reusableIdentifier, bundle: nil), forCellWithReuseIdentifier: TopCastCollectionCell.reusableIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension TopCastCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return castArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopCastCollectionCell.reusableIdentifier, for: indexPath) as? TopCastCollectionCell else {return UICollectionViewCell()}
        let castData = castArr[indexPath.row]
        cell.set(castData)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let personId = castArr[indexPath.row].id ?? 0
        let title = castArr[indexPath.row].name
        guard let allCastDetailVC = UIApplication.shared.firstKeyWindow?.rootViewController as? UINavigationController else {return}
        allCastDetailVC.title = title
        allCastDetailVC.pushViewController(AllCastDetailVC(personID: personId), animated: true)
    }
}

