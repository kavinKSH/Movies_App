//
//  KeywordMoviesListVC.swift
//  Movies_App
//
//  Created by Kavin on 10/05/24.
//

import UIKit

class KeywordMoviesListVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var keywordMovieVM: KeywordMoviesVM?
    var page: Int = 1
    var hasmoreMovies: Bool = true
    var keywordName: String? = ""
    
    var keywordID: Int? = 0 {
        didSet {
            
        }
    }
    var keywordMoviesArr = [KeywordMoviesListData]() {
        didSet{
            DispatchQueue.main.async { [weak self] in
                guard let self else {return}
                setupTableView()
                tableView.reloadData()
            }
        }
    }
    
    init(keywordID: Int) {
        super.init(nibName: "KeywordMoviesListVC", bundle: nil)
        self.keywordID = keywordID
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showActivityIndicatorAnimation()
        keywordMovieVM = KeywordMoviesVM(client: HTTPClient(), delegate: self)
        keywordMovieVM?.getKeywordMoviesListData(id: keywordID ?? 0, page: page)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.tintColor = UIColor.label
        navigationController?.navigationBar.topItem?.backButtonDisplayMode = .minimal
        title = keywordName
    }
    
    func setupTableView() {
        tableView.register(UINib(nibName: KeywordMoviesListCell.reusabkeIdentifier, bundle: nil), forCellReuseIdentifier: KeywordMoviesListCell.reusabkeIdentifier)
        tableView.dataSource    = self
        tableView.delegate      = self
    }
    
    func showActivityIndicatorAnimation() {
        keywordMovieVM?.isloading.bind({ [weak self] isLoading in
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
}

extension KeywordMoviesListVC: KeywordsMoviesDelegate {
    func didReciveKeywordMoviesListData(_ decodedData: KeywordMoviesListModel) {
        showActivityIndicatorAnimation()
        keywordMoviesArr.append(contentsOf: decodedData.results ?? [])

        if decodedData.results?.count ?? 0 < 20 {
            hasmoreMovies = false
        }
    }
    
    func didFailuresKeywordMoviesListData(_ error: String) {
        showActivityIndicatorAnimation()
        showError(title: "Keyword movies error", error: error)
    }
}


extension KeywordMoviesListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return keywordMoviesArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: KeywordMoviesListCell.reusabkeIdentifier, for: indexPath) as? KeywordMoviesListCell else {return UITableViewCell()}
        let keywordMovies = keywordMoviesArr[indexPath.row]
        cell.set(keywordMovies)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = keywordMoviesArr[indexPath.row].id ?? 0
        let movieDetailVC = AllMovieDetailVC(movieID: id)
        navigationController?.pushViewController(movieDetailVC, animated: true)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY         = scrollView.contentOffset.y
        let contentHeight   = scrollView.contentSize.height
        let height          = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            guard hasmoreMovies else {return}
            page += 1
            keywordMovieVM?.getKeywordMoviesListData(id: keywordID ?? 0, page: page)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    }
}

