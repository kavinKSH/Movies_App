//
//  TrendingCell.swift
//  Movies_App
//
//  Created by Kavin on 10/05/24.
//

import UIKit

class TrendingCell: UITableViewCell {
    
    
    @IBOutlet weak var trendingCollectionView: UICollectionView!
    @IBOutlet weak var trendingHeadlineLabel: UILabel!
    @IBOutlet weak var rightButton: UIButton!
    
    var page: Int = 1
    var trendingVM: TrendingVM?
    var hasLoadMoreMovies: Bool? = true
    
    static var reusableIdentifier: String {
        return String(describing: self)
    }
    
    var trendingMoviesArr = [TrendingMoviesData]() {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self else {return}
                trendingCollectionView.delegate = self
                trendingCollectionView.dataSource = self
                trendingCollectionView.reloadData()
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
        trendingCollectionView.collectionViewLayout = flowLayout
        trendingCollectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        flowLayout.itemSize = .init(width: 150, height: 280)
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 10
                
        trendingCollectionView.register(UINib(nibName: TrendingCollectionCell.reusableIdentifireforTrending, bundle: nil), forCellWithReuseIdentifier: TrendingCollectionCell.reusableIdentifireforTrending)
        
    }
    
    func setTrendingDatas(_ trendingDatas: [TrendingMoviesData]) {
        trendingMoviesArr = trendingDatas
    }
}

extension TrendingCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        trendingMoviesArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = trendingCollectionView.dequeueReusableCell(withReuseIdentifier: TrendingCollectionCell.reusableIdentifireforTrending, for: indexPath) as? TrendingCollectionCell else { return UICollectionViewCell() }
        trendingHeadlineLabel.text = "Trending Movies"
        let trendingDatas = trendingMoviesArr[indexPath.row]
        cell.set(trendingDatas)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let moviesId = trendingMoviesArr[indexPath.row].id
        print(indexPath.row)
        guard let allDetailVC = UIApplication.shared.firstKeyWindow?.rootViewController as? UINavigationController else {return}
        allDetailVC.pushViewController(AllMovieDetailVC(movieID: moviesId ?? 0), animated: true)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetX         = scrollView.contentOffset.x
        let contentHeight   = scrollView.contentSize.width
        let height          = scrollView.frame.size.width
        
        if offsetX > contentHeight - height {
            page += 1
            guard hasLoadMoreMovies ?? true else {return}
            trendingVM = TrendingVM(client: HTTPClient(), delegate: self)
            trendingVM?.getTrendingMoviesDatas(page: page)
        }
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        showAnimation()
    }
}

extension TrendingCell: TrendingMoviesDelegate {
    func didSuccessWithTrendingMoviesData(_ decodedData: TrendingMoviesModel) {
        if decodedData.results.count < 20 {
            hasLoadMoreMovies = false
        }
        trendingMoviesArr.append(contentsOf: decodedData.results)
    }
    
    func didFailureWithTrendingMoviesData(_ error: String) {
        
    }
}
