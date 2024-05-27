//
//  UpcomingMoviesCell.swift
//  Movies_App
//
//  Created by Kavin on 10/05/24.
//

import UIKit

class UpcomingMoviesCell: UITableViewCell {
    
    @IBOutlet weak var upcomingCollectionView: UICollectionView!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var headLineLabel: UILabel!
    
    var page: Int = 1
    var hasMoreMovies: Bool = true
    var upcomingVM: UpcomingMoviesVM?
    
    static var reusableIdentifier: String {
        return String(describing: self)
    }
    
    var upcomingMoviesArray = [UpcomingMovies]() {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self else {return}
                upcomingCollectionView.dataSource = self
                upcomingCollectionView.delegate   = self
                upcomingCollectionView.reloadData()
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
        upcomingCollectionView.collectionViewLayout = flowLayout
        upcomingCollectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        flowLayout.itemSize = .init(width: 150, height: 280)
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 10

        upcomingCollectionView.register(UINib(nibName: UpcomingCollectionViewCell.reusableIdentifier, bundle: nil), forCellWithReuseIdentifier: UpcomingCollectionViewCell.reusableIdentifier)
    }
    
    func setUpcomingDatas(upcomingDatas: [UpcomingMovies]) {
        upcomingMoviesArray = upcomingDatas
    }
}

extension UpcomingMoviesCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        upcomingMoviesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = upcomingCollectionView.dequeueReusableCell(withReuseIdentifier: UpcomingCollectionViewCell.reusableIdentifier, for: indexPath) as? UpcomingCollectionViewCell else {return UICollectionViewCell()}
        let upcomingMoviesData = upcomingMoviesArray[indexPath.row]
        cell.set(upcomingMoviesData)
        headLineLabel.text = "UpComing Movies"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let moviesId = upcomingMoviesArray[indexPath.row].id
        guard let allDetailVC = UIApplication.shared.firstKeyWindow?.rootViewController as? UINavigationController else {return}
        allDetailVC.pushViewController(AllMovieDetailVC(movieID: moviesId ?? 0), animated: true)
    }
    
    
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetX         = scrollView.contentOffset.x
        let contentHeight   = scrollView.contentSize.width
        let height          = scrollView.frame.size.width
        
        if offsetX > contentHeight - height {
            guard hasMoreMovies else {return}
            page += 1
            upcomingVM = UpcomingMoviesVM(client: HTTPClient(), delegate: self)
            upcomingVM?.getUpcomingDatas(page: page)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        showAnimation()
    }
}

extension UpcomingMoviesCell: UpcomingMoviesDelegate {
    func didReciveUpcomingMoviesDatas(_ decodedData: UpcomingMovieDatas) {
        if decodedData.results.count < 20 {
            hasMoreMovies = false
        }
        upcomingMoviesArray.append(contentsOf: decodedData.results)
    }
    
    func didFailureUpcomingMoviesData(_ error: String) {
        
    }
}
