//
//  HomeViewController.swift
//  Movies_App
//
//  Created by Kavin on 10/05/24.
//

import UIKit

enum SectionsOfCollection {
    case main
}
class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var totalPages              : Int = 1
    var hasmoreMovies           : Bool = true
    
    var nowPlayingVM            : NowPlayingMoviesVM?
    var trendingVM              : TrendingVM?
    var popularVM               : PopularVM?
    var upcomingVM              : UpcomingMoviesVM?
    var topRatedVM              : TopRatedVM?
    var tvShowVM                : TVShowVM?
    var moviesVM                : MoviesVM?
    
    var nowPlayingDict          = [String: [NowPlayingMovies]]()
    var trendingDict            = [String: [TrendingMoviesData]]()
    var popularDict             = [String: [PopularMovies]]()
    var upcomingDict            = [String: [UpcomingMovies]]()
    var topRatedDict            = [String: [TopRatedMovies]]()
    var tvDict                  = [String: [TVDatas]]()
    var moviesDict              = [String: [Movies]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDatas()
        setupTableView()
    }
    
    func getDatas() {
        activityIndicaterAnimation()
        nowPlayingVM = NowPlayingMoviesVM(client: HTTPClient(), delegate: self)
        nowPlayingVM?.getNowPlayingDatas(page: 1)
        
        trendingVM = TrendingVM(client: HTTPClient(), delegate: self)
        trendingVM?.getTrendingMoviesDatas(page: 1)
        
        popularVM = PopularVM(client: HTTPClient(), delegate: self)
        popularVM?.getPopularDatas(page: 1)
        
        upcomingVM = UpcomingMoviesVM(client: HTTPClient(), delegate: self)
        upcomingVM?.getUpcomingDatas(page: 1)
        
        topRatedVM = TopRatedVM(client: HTTPClient(), delegate: self)
        topRatedVM?.getTopRatedMoviesData(page: 1)
        
        tvShowVM = TVShowVM(client: HTTPClient(), delegate: self)
        tvShowVM?.getTVShowDatas(page: 1)
        
        moviesVM = MoviesVM(client: HTTPClient(), delegate: self)
        moviesVM?.getMovies(page: 1)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "For you"
        navigationItem.largeTitleDisplayMode = .automatic
        
        let rightBarButton = UIBarButtonItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), target: self, action: #selector(searchMovies))
        self.navigationItem.rightBarButtonItem = rightBarButton
        rightBarButton.tintColor = .label
        
        let leftBarButton = UIBarButtonItem(title: "Movies", image: UIImage(systemName: "movieclapper.fill"), target: self, action: #selector(getMovies))
        self.navigationItem.leftBarButtonItem = leftBarButton
        leftBarButton.tintColor = .label
    }
    
    @objc func getMovies() {
    }
    
    @objc func searchMovies() {
        let searchVC = SearchVC()
        navigationController?.pushViewController(searchVC, animated: true)
        searchVC.title = "Search Movies"
    }
    
    func activityIndicaterAnimation() {
        nowPlayingVM?.isLoading.bind({ [weak self] isLoading in
            guard let self, let isLoading else {return}
            showActivityIndicator(isLoading: isLoading)
        })
        trendingVM?.isLoading.bind({[weak self] isLoading in
            guard let self , let isLoading else {return}
            showActivityIndicator(isLoading: isLoading)
        })
        popularVM?.isLoading.bind({[weak self] isLoading in
            guard let self,let isLoading else {return}
            showActivityIndicator(isLoading: isLoading)
        })
        upcomingVM?.isLoading.bind({[weak self] isLoading in
            guard let self, let isLoading else {return}
            showActivityIndicator(isLoading: isLoading)
        })
        topRatedVM?.isLoading.bind({[weak self] isLoading in
            guard let self, let isLoading else {return}
            showActivityIndicator(isLoading: isLoading)
        })
        tvShowVM?.isLoading.bind({[weak self] isLoading in
            guard let self, let isLoading else {return}
            showActivityIndicator(isLoading: isLoading)
        })
        moviesVM?.isLoading.bind({[weak self] isLoading in
            guard let self, let isLoading else {return}
            showActivityIndicator(isLoading: isLoading)
        })
    }
    
    func showActivityIndicator(isLoading: Bool = false) {
        DispatchQueue.main.async { [weak self] in
            guard let self else {return}
            if isLoading {
                self.activityIndicator.startAnimating()
            }else {
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    func setupTableView() {
        tableView.register(UINib(nibName: NowPlayingTableViewCell.reusableIdentifier, bundle: nil), forCellReuseIdentifier: NowPlayingTableViewCell.reusableIdentifier)
        tableView.register(UINib(nibName: TrendingCell.reusableIdentifier, bundle: nil), forCellReuseIdentifier: TrendingCell.reusableIdentifier)
        tableView.register(UINib(nibName: PopularCell.reusableIdentifier, bundle: nil), forCellReuseIdentifier: PopularCell.reusableIdentifier)
        tableView.register(UINib(nibName: TopRatedTableViewCell.reusableIdentifier, bundle: nil), forCellReuseIdentifier: TopRatedTableViewCell.reusableIdentifier)
        tableView.register(UINib(nibName: UpcomingMoviesCell.reusableIdentifier, bundle: nil), forCellReuseIdentifier: UpcomingMoviesCell.reusableIdentifier)
        tableView.register(UINib(nibName: TVTableCell.reusableIdentifier, bundle: nil), forCellReuseIdentifier: TVTableCell.reusableIdentifier)
        
        tableView.register(UINib(nibName: MoviesTableViewCell.reusableIdentifier, bundle: nil), forCellReuseIdentifier: MoviesTableViewCell.reusableIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }
}

//MARK: - Protocol Delegate

extension HomeViewController: TrendingMoviesDelegate {
    func didSuccessWithTrendingMoviesData(_ decodedData: TrendingMoviesModel) {
        activityIndicaterAnimation()
        trendingDict.updateValue(decodedData.results, forKey: "Trending")
    }
    
    func didFailureWithTrendingMoviesData(_ error: String) {
        activityIndicaterAnimation()
        showError(title: "Trending error", error: error)

    }
}

extension HomeViewController: NowPlayingMoviesDelegate {
    func didReciveSuccessWithNowPlayinData(of decodedData: NowPlayingMoviesData) {
        nowPlayingDict.updateValue(decodedData.results, forKey: "NowPlaying")
        DispatchQueue.main.async { [weak self] in
            guard let self else {return}
            tableView.reloadData()
        }
    }
    
    func didFailuresWithNowPlayingData(of error: String) {
        showError(title: "Now playing movies error", error: error)
    }
}

extension HomeViewController: popularMoviesDelegate {
    func didRecivePopularDatas(_ decodedData: PopularMoviesData) {
        popularDict.updateValue(decodedData.results, forKey: "Popular")
    }
    
    func didFailurePopularDatas(_ error: String) {
        showError(title: "Popular movies data error", error: error)
    }
}

extension HomeViewController: UpcomingMoviesDelegate {
    func didReciveUpcomingMoviesDatas(_ decodedData: UpcomingMovieDatas) {
        upcomingDict.updateValue(decodedData.results, forKey: "Upcoming")
    }
    
    func didFailureUpcomingMoviesData(_ error: String) {
        showError(title: "Upcoming Movies Error", error: error)
    }
}

extension HomeViewController: TopRatedMoviesDelegate {
    func didReciveTopRatedMoviesData(_ decodedData: TopRatedMoviesData) {
        topRatedDict.updateValue(decodedData.results, forKey: "TopRated")
    }
    
    func didFailureTopRatedMoviesData(_ error: String) {
        showError(title: "Top rated movies error", error: error)
    }
}

extension HomeViewController: TVShowsDelegate {
    func didReciveTVShowData(_ decodedData: TVModelDatas) {
        tvDict.updateValue(decodedData.results, forKey: "TVShows")
    }
    
    func didFailureTVShowsData(_ error: String) {
        showError(title: "Popular Movies error", error: error)
    }
}

extension HomeViewController: MoviesDelegate {
    func didReciveSuccessWithMoviesData(of decodedData: MoviesData) {
        moviesDict.updateValue(decodedData.results ?? [], forKey: "Movies")
    }
    
    func didReciveFailureWithMoviesData(of error: String) {
        showError(title: "Movies Error", error: error)
    }
}
