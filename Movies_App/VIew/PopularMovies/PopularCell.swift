//
//  PopularCell.swift
//  Movies_App
//
//  Created by Kavin on 10/05/24.
//

import UIKit

class PopularCell: UITableViewCell {
    
    @IBOutlet weak var popularCollectionView: UICollectionView!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var headLineLabel: UILabel!
    
    var page: Int = 1
    var hasmoreMovies: Bool = true
    var popularVM: PopularVM?
    
    lazy var containerView: UIView = {
        var view = UIView()
        return view
    }()
    
    static var reusableIdentifier: String {
        return String(describing: self)
    }
    
    var popularMoviesArray = [PopularMovies]() {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self else {return}
                popularCollectionView.dataSource = self
                popularCollectionView.delegate   = self
                popularCollectionView.reloadData()
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
    
    func showActivityIndicatorAnimation() {
        popularVM?.isLoading.bind({ [weak self] isLoading in
            guard let self else {return}
            if isLoading ?? true {
                print("Loading")

                showLoadingView()
            }else {
                print("Stop Loading")

                stopLoadingView()
            }
        })
    }
    
    func showLoadingView() {
        containerView = UIView(frame: self.bounds)
        self.addSubview(containerView)
        containerView.backgroundColor   = .systemBackground
        containerView.alpha             = 0
        UIView.animate(withDuration: 5) {
            self.containerView.alpha = 0.8
        }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
        
        print("Animation")
        activityIndicator.startAnimating()
        
    }
    
    func stopLoadingView() {
        DispatchQueue.main.async { [weak self] in
            self?.containerView.removeFromSuperview()
            print("stop animation")

        }
    }
    
    func setupCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        popularCollectionView.collectionViewLayout = flowLayout
        popularCollectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        flowLayout.itemSize = .init(width: 150, height: 280)
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 10
        
        popularCollectionView.register(UINib(nibName: PopularCollectionCell.reusableIdentifier, bundle: nil), forCellWithReuseIdentifier: PopularCollectionCell.reusableIdentifier)
    }
    
    func setPopularDatas(_ popularDatas: [PopularMovies]) {
        popularMoviesArray = popularDatas
    }
}

extension PopularCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        popularMoviesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = popularCollectionView.dequeueReusableCell(withReuseIdentifier: PopularCollectionCell.reusableIdentifier , for: indexPath) as? PopularCollectionCell else {return UICollectionViewCell()}
        let popularMovies = popularMoviesArray[indexPath.row]
        cell.set(popularMovies)
        headLineLabel.text = "Popular Movies"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let moviesId = popularMoviesArray[indexPath.row].id
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
            popularVM = PopularVM(client: HTTPClient(), delegate: self)
            popularVM?.getPopularDatas(page: page)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    }
}

extension PopularCell: popularMoviesDelegate {
    func didRecivePopularDatas(_ decodedData: PopularMoviesData) {
        if decodedData.results.count < 20 {
            hasmoreMovies = false
        }
        popularMoviesArray.append(contentsOf: decodedData.results)
    }
    
    func didFailurePopularDatas(_ error: String) {
        showError(title: "Popular movies error", error: error)
    }
}
