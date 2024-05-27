//
//  SimilerCell.swift
//  Movies_App
//
//  Created by Kavin on 09/05/24.
//

import UIKit

class SimilerCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var headLinelabel: UILabel!
    
    static var reusableIdentifier: String {
        return String(describing: self)
    }
    var page: Int = 1
    var hasmoreMovies: Bool = true
    var similerArray = [Similer]() {
        didSet {
            DispatchQueue.main.async {[weak self] in
                guard let self else{return}
                setUpCollectionViewCell()
                collectionView.reloadData()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setSimilerDatas(_ similerDatas: [Similer]) {
        similerArray = similerDatas
    }
    
    func setUpCollectionViewCell() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = .init(width: self.frame.size.width - 50, height: 220)
        flowLayout.sectionInset = .init(top: 0, left: 0, bottom: 0, right: 10)
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = flowLayout
        
        collectionView.register(UINib(nibName: SimilerCollectionCell.reusableIdentifier, bundle: nil), forCellWithReuseIdentifier: SimilerCollectionCell.reusableIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension SimilerCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return similerArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SimilerCollectionCell.reusableIdentifier, for: indexPath) as? SimilerCollectionCell else {return UICollectionViewCell()}
        headLinelabel.text = "Similer Movies"
        let similer = similerArray[indexPath.row]
        cell.set(similer)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let moviesId = similerArray[indexPath.row].id
        print(indexPath.row)
        guard let allDetailVC = UIApplication.shared.firstKeyWindow?.rootViewController as? UINavigationController else {return}
        allDetailVC.pushViewController(AllMovieDetailVC(movieID: moviesId ?? 0), animated: true)
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetX         = scrollView.contentOffset.x
        let contentHeight   = scrollView.contentSize.width
        let height          = scrollView.frame.size.width
        
        if offsetX > contentHeight - height {
            guard hasmoreMovies else {return}
            page += 1
        }
    }
}
