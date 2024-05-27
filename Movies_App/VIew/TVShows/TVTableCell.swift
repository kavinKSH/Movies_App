//
//  TVTableCell.swift
//  Movies_App
//
//  Created by Kavin on 10/05/24.
//

import UIKit

class TVTableCell: UITableViewCell {
    
    @IBOutlet weak var tvCollectionView: UICollectionView!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var headLineLabel: UILabel!
    
    var page: Int = 1
    var hasmoreMovies: Bool = true
    var tvShowVM: TVShowVM?
    
    static var reusableIdentifier: String {
        return String(describing: self)
    }
    
    var tvShowArray = [TVDatas]() {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self else {return}
                tvCollectionView.dataSource = self
                tvCollectionView.delegate   = self
                tvCollectionView.reloadData()
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
        tvCollectionView.collectionViewLayout = flowLayout
        tvCollectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        flowLayout.itemSize = .init(width: 150, height: 280)
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 10
        
        tvCollectionView.register(UINib(nibName: TVCollectionCell.reusableIdentifier, bundle: nil), forCellWithReuseIdentifier: TVCollectionCell.reusableIdentifier)
    }
    
    func setTVDatas(_ tvDatas: [TVDatas]) {
        tvShowArray = tvDatas
    }
}

extension TVTableCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        tvShowArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = tvCollectionView.dequeueReusableCell(withReuseIdentifier: TVCollectionCell.reusableIdentifier, for: indexPath) as? TVCollectionCell else {return UICollectionViewCell()}
        let tvDatas = tvShowArray[indexPath.row]
        cell.set(tvDatas)
        headLineLabel.text = "TV Shows"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let moviesId = tvShowArray[indexPath.row].id
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
            tvShowVM = TVShowVM(client: HTTPClient(), delegate: self)
            tvShowVM?.getTVShowDatas(page: page)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        showAnimation()
    }
}

extension TVTableCell: TVShowsDelegate {
    func didReciveTVShowData(_ decodedData: TVModelDatas) {
        if decodedData.results.count < 20 {
            hasmoreMovies = false
        }
        tvShowArray.append(contentsOf: decodedData.results)
    }
    
    func didFailureTVShowsData(_ error: String) {
        
    }
}
