//
//  NowPlayingTableViewCell.swift
//  Movies_App
//
//  Created by Kavin on 18/05/24.
//

import UIKit

class NowPlayingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    static var reusableIdentifier: String {
        return String(describing: self)
    }
    var page: Int = 1
    var hasMoreMovies: Bool? = true
    var nowPlayingVM: NowPlayingMoviesVM?
    var nowPlayingArr = [NowPlayingMovies]() {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self else {return}
                collectionView.reloadData()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCollectionViewLayouts()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setUpCollectionViewLayouts()
    }
    
    func setUpCollectionViewLayouts() {
        collectionView.collectionViewLayout = createTrendingCollectionViewLayout()
        collectionView.register(UINib(nibName: NowPlayingCell.reusableIdentifier, bundle: nil), forCellWithReuseIdentifier: NowPlayingCell.reusableIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func setNowPlayingDatas(_ datas: [NowPlayingMovies]) {
        nowPlayingArr = datas
    }
}

extension NowPlayingTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        nowPlayingArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NowPlayingCell.reusableIdentifier, for: indexPath) as? NowPlayingCell else
        {return UICollectionViewCell()}
        let nowPlaying = nowPlayingArr[indexPath.row]
        
        cell.alpha = 0
        UIView.animate(withDuration: 3) {
            cell.alpha = 1
            cell.setCellDatas(nowPlaying)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let moviesId = nowPlayingArr[indexPath.row].id
        print(indexPath.row)
        guard let allDetailVC = UIApplication.shared.firstKeyWindow?.rootViewController as? UINavigationController else {return}
        allDetailVC.pushViewController(AllMovieDetailVC(movieID: moviesId ?? 0), animated: true)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetX         = scrollView.contentOffset.x
        let contentHeight   = scrollView.contentSize.width
        let width           = scrollView.frame.size.width
        
        if offsetX > contentHeight - width {
            guard hasMoreMovies ?? true else {return}
            page += 1
            nowPlayingVM = NowPlayingMoviesVM(client: HTTPClient(), delegate: self)
            nowPlayingVM?.getNowPlayingDatas(page: page)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        showAnimation()
    }
}

extension NowPlayingTableViewCell: NowPlayingMoviesDelegate {
    func didReciveSuccessWithNowPlayinData(of decodedData: NowPlayingMoviesData) {
        if decodedData.results.count < 20 {
            hasMoreMovies = false
        }
        nowPlayingArr.append(contentsOf: decodedData.results)
    }
    
    func didFailuresWithNowPlayingData(of error: String) {
        showError(title: "Error", error: error)
    }
}
