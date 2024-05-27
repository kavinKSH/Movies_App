//
//  TopRatedTableViewCell.swift
//  Movies_App
//
//  Created by Kavin on 10/05/24.
//

import UIKit

class TopRatedTableViewCell: UITableViewCell {
    
    @IBOutlet weak var topRatedCollectionView: UICollectionView!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var headLineLabel: UILabel!
    
    var page: Int = 1
    var hasmoreMovies: Bool = true
    var topRatedVM: TopRatedVM?
    
    static var reusableIdentifier: String {
        return String(describing: self)
    }
    
    var topRatedArray = [TopRatedMovies]() {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self else {return}
                topRatedCollectionView.reloadData()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setupCollectionView()
    }
    
    func setupCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        topRatedCollectionView.collectionViewLayout = flowLayout
        topRatedCollectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        flowLayout.itemSize = .init(width: 150, height: 280)
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 10
        
        topRatedCollectionView.register(UINib(nibName: TopRatedCollectionCell.reusableIdentifier, bundle: nil), forCellWithReuseIdentifier: TopRatedCollectionCell.reusableIdentifier)
        topRatedCollectionView.dataSource = self
        topRatedCollectionView.delegate   = self
    }
    
    func setTopRatedDatas(_ topRatedDatas: [TopRatedMovies]) {
        topRatedArray = topRatedDatas
    }
}

extension TopRatedTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        topRatedArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = topRatedCollectionView.dequeueReusableCell(withReuseIdentifier: TopRatedCollectionCell.reusableIdentifier, for: indexPath) as? TopRatedCollectionCell else {return UICollectionViewCell()}
        let topRatedMovies = topRatedArray[indexPath.row]
        cell.set(topRatedMovies)
        headLineLabel.text = "Top Rated Movies"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let moviesId = topRatedArray[indexPath.row].id
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
            topRatedVM = TopRatedVM(client: HTTPClient(), delegate: self)
            topRatedVM?.getTopRatedMoviesData(page: page)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        showAnimation()
    }
}

extension TopRatedTableViewCell: TopRatedMoviesDelegate {
    func didReciveTopRatedMoviesData(_ decodedData: TopRatedMoviesData) {
        if decodedData.results.count < 20 {
            hasmoreMovies = false
        }
        topRatedArray.append(contentsOf: decodedData.results)
    }
    
    func didFailureTopRatedMoviesData(_ error: String) {
        
    }
    
    
}
