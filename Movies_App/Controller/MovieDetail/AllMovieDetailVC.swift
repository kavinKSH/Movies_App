//
//  AllMovieDetailVC.swift
//  Movies_App
//
//  Created by Kavin on 16/05/24.
//

import UIKit

class AllMovieDetailVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var movieDetaiVM                : MovieDetailVM?
    var keywordVM                   : KeywordVM?
    var reviewersVM                 : ReviwersVM?
    var videosVM                    : VideosVM?
    var collectionVM                : CollectionVM?
    var similerVM                   : SimilerVM?
    var keywordDict                 = [String: [Keywords]]()
    var reviewersDict               = [String: ReviwersData]()
    var videosDict                  = [String: VideosData]()
    var collectionDict              = [String: CollectionData]()
    var similerDict                 = [String: SimilerData]()
    
    var isVisibleReviewCell         : Bool = true
    var isVisibleKeywordCell        : Bool = true
    var isVisibleVideosCell         : Bool = true
    var isVisibleSimilerCell        : Bool = true
    var isVisibleCollectionCell     : Bool = true
    var isVisibleCompanyCell        : Bool = true
    var isVisibleCastCell           : Bool = true

    var movieID                     : Int?
    var isMovieAvailable            : Bool = false
    
    var movieDetailId: Int? = 0 {
        didSet {
            keywordVM = KeywordVM(client: HTTPClient(), delegate: self)
            keywordVM?.getKeywordData(id: movieDetailId ?? 0)
            reviewersVM = ReviwersVM(client: HTTPClient(), delegate: self)
            reviewersVM?.getReviwersData(id: movieDetailId ?? 0)
            videosVM = VideosVM(client: HTTPClient(), delegate: self)
            videosVM?.getVideosData(id: movieDetailId ?? 0)
            similerVM = SimilerVM(client: HTTPClient(), delegate: self)
            similerVM?.getSimilerData(id: movieDetailId ?? 0)
        }
    }
    
    var collectionId : Int? {
        didSet {
            collectionVM = CollectionVM(client: HTTPClient(), delegate: self)
            collectionVM?.getPartOfCollectionData(collectionId: collectionId ?? 0)
        }
    }
    
    var moviesDetailDict = [String: MoviesDetailData]() {
        didSet {
            DispatchQueue.main.async {[weak self] in
                guard let self else {return}
                registerTableViewCells()
                tableView.reloadData()
            }
        }
    }
    
    init(movieID: Int) {
        super.init(nibName: "AllMovieDetailVC", bundle: nil)
        self.movieID = movieID
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieDetaiVM = MovieDetailVM(client: HTTPClient(), delegate: self)
        movieDetaiVM?.getMoviesDetail(id: movieID ?? 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.tintColor = UIColor.label
        navigationController?.navigationBar.topItem?.backButtonDisplayMode = .minimal
        navigationController?.navigationBar.topItem?.backBarButtonItem?.tintColor = .label
        navigationController?.setNavigationBarHidden(false, animated: true)
        title = "Movie Details"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func updateContentUnavailableConfiguration(using state: UIContentUnavailableConfigurationState) {
        if isMovieAvailable && moviesDetailDict.isEmpty {
            var config = UIContentUnavailableConfiguration.empty()
            config.image = .init(systemName: "movieclapper")
            config.text = "Oops. We don't have that! movie datas"
            config.secondaryText = "please watch another movies!"
            contentUnavailableConfiguration = config
            contentUnavailableConfiguration = nil
        }else {
            contentUnavailableConfiguration = nil
        }
    }
    
    func showEmptyState() {
        DispatchQueue.main.async { [weak self] in
            guard let self else {return}
            setNeedsUpdateContentUnavailableConfiguration()
        }
    }
    
    func registerTableViewCells() {
        tableView.register(UINib(nibName: PosterCell.reusableIdentifier, bundle: nil), forCellReuseIdentifier: PosterCell.reusableIdentifier)
        tableView.register(UINib(nibName: DetailCell.reusableIdentfier, bundle: nil), forCellReuseIdentifier: DetailCell.reusableIdentfier)
        tableView.register(UINib(nibName: TopCastCell.reusableIdentifier, bundle: nil), forCellReuseIdentifier: TopCastCell.reusableIdentifier)
        tableView.register(UINib(nibName: KeywordCell.reusableIdentifier, bundle: nil), forCellReuseIdentifier: KeywordCell.reusableIdentifier)
        tableView.register(UINib(nibName: ProductionCompanyCell.reusableIdentifier, bundle: nil), forCellReuseIdentifier: ProductionCompanyCell.reusableIdentifier)
        tableView.register(UINib(nibName: ReviewersCell.reuseIdenitifier, bundle: nil), forCellReuseIdentifier: ReviewersCell.reuseIdenitifier)
        tableView.register(UINib(nibName: VideosCell.reusableIdentifier, bundle: nil), forCellReuseIdentifier: VideosCell.reusableIdentifier)
        tableView.register(UINib(nibName: MoviesCollectionsCell.reusableIdentifier, bundle: nil), forCellReuseIdentifier: MoviesCollectionsCell.reusableIdentifier)
        tableView.register(UINib(nibName: SimilerCell.reusableIdentifier, bundle: nil), forCellReuseIdentifier: SimilerCell.reusableIdentifier)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }
}

extension AllMovieDetailVC: KeywordsDelegate, ReviwersDelegate, VideosDelegate, SimilerDelegate, CollectionsDelegate, MoviesDetailDelegate {
    func didReciveMoviesDetailData(_ decodedData: MoviesDetailData) {
        moviesDetailDict.updateValue(decodedData, forKey: Keys.movieDetails)
        movieDetailId = decodedData.id
        collectionId = decodedData.belongsToCollection?.id
        if moviesDetailDict[Keys.movieDetails]?.title?.count ?? 0 >= 1 || moviesDetailDict[Keys.movieDetails]?.originalTitle?.count ?? 0 >= 1 || moviesDetailDict[Keys.movieDetails]?.credits?.cast?.count ?? 0 >= 1 {
            isMovieAvailable = false
            showEmptyState()
        }else {
            isMovieAvailable = true
            showEmptyState()
        }
    }
    
    func didFailureMoviesDetailData(_ error: String) {
        showError(title: "Movie detail error", error: error)
    }
    
    func didReciveKeywordMovies(_ decodedData: KeywordData) {
        keywordDict.updateValue(decodedData.keywords ?? [], forKey: Keys.keyword)
    }
    
    func didFailuresKeywordMovies(_ error: String) {}
    
    func didReciveReviwersComments(_ decodedData: ReviwersData) {
        reviewersDict.updateValue(decodedData, forKey: Keys.reviewers)
    }
    
    func didFailureMovieReviewersData(_ error: String) {}
    
    func didReciveVideosData(_ decodedData: VideosData) {
        videosDict.updateValue(decodedData, forKey: Keys.videos)
    }
    
    func didFailureWithVideosData(_ error: String) {}
    
    func didReciveSimilerDatas(_ decodedData: SimilerData) {
        similerDict.updateValue(decodedData, forKey: Keys.similer)
    }
    
    func didFailureWithSimilerDatas(_ error: String) {}
    
    func didRecivePartOftheCollectionsData(_ decodedData: CollectionData) {
        collectionDict.updateValue(decodedData, forKey: Keys.collections)
    }
    
    func didFailurePartOfTheCollectionData(_ error: String) {}
}
