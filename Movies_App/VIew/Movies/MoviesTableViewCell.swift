//
//  MoviesTableViewCell.swift
//  Movies_App
//
//  Created by Kavin on 10/05/24.
//

import UIKit

class MoviesTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var headLineLabel: UILabel!
    
    var page            : Int  = 1
    var hasmoreMovies   : Bool  = true
    var moviesVM: MoviesVM?
    
    var moviesArr: [Movies] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self else {return}
                collectionView.delegate = self
                collectionView.dataSource = self
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
        collectionView.backgroundColor = .systemBackground
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setUpCollectionViewCell()
        collectionView.backgroundColor = .systemBackground
    }
    
    func setUpCollectionViewCell() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = flowLayout
        collectionView.contentInset = .init(top: 0, left: 10, bottom: 0, right: 10)

        flowLayout.itemSize = CGSize(width: 150 , height: 280)
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 10
        
        collectionView.register(UINib(nibName: MoviesCollectionViewCell.reusableCollectionIdentifier, bundle: nil), forCellWithReuseIdentifier: MoviesCollectionViewCell.reusableCollectionIdentifier)
    }
    
    func setMoviesDatas(_ movieDatas: [Movies]) {
        moviesArr = movieDatas
    }
}

//MARK: - UICollectionView Delegate and DataSource

extension MoviesTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviesCollectionViewCell.reusableCollectionIdentifier, for: indexPath) as? MoviesCollectionViewCell else{
            return UICollectionViewCell()
        }
        headLineLabel.text = "Movie Collections"
        let moviesData = moviesArr[indexPath.item]
        cell.set(moviesData)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let moviesId = moviesArr[indexPath.row].id
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
            moviesVM = MoviesVM(client: HTTPClient(), delegate: self)
            moviesVM?.getMovies(page: page)
        }
    }
}

extension MoviesTableViewCell: MoviesDelegate {
    func didReciveSuccessWithMoviesData(of decodedData: MoviesData) {
        if decodedData.results?.count ?? 0 < 20 {
            hasmoreMovies = false
        }
        moviesArr.append(contentsOf: decodedData.results ?? [])
    }
}

