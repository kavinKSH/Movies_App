//
//  SearchVC.swift
//  Movies_App
//
//  Created by Kavin on 10/05/24.
//

import UIKit

enum Sections {
    case main
}

class SearchVC: UIViewController {
    
    @IBOutlet weak var searchbar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var movieDetailsArr = [SearchMovies]()
    var dataSource      : UITableViewDiffableDataSource<Sections, SearchMovies >!
    var searchVM        : SearchVM?
    var isSearching     : Bool = false
    
    var movieName       : String? {
        didSet {
            searchVM?.getSearchedMovies(movie: movieName ?? "")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchVM = SearchVM(client: HTTPClient(), delegate: self)
        tableView.register(UINib(nibName: SearchCell.reusableIdentifier, bundle: nil), forCellReuseIdentifier: SearchCell.reusableIdentifier)
        searchbar.delegate = self
        tableView.delegate = self
        configureTableview()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.topItem?.backButtonDisplayMode = .minimal
        navigationController?.setNavigationBarHidden(false, animated: true)
        title = "Search Movies"
    }
    
    override func updateContentUnavailableConfiguration(using state: UIContentUnavailableConfigurationState) {
        if movieDetailsArr.isEmpty && isSearching {
            var config = UIContentUnavailableConfiguration.empty()
            config.image = .init(systemName: "magnifyingglass")
            config.text = "Oops. We don't have that"
            config.secondaryText = "Try searching for another movies"
            contentUnavailableConfiguration = config
        }
        else{
            contentUnavailableConfiguration = nil
        }
    }
    
    func configureTableview() {
        dataSource = UITableViewDiffableDataSource<Sections, SearchMovies>(tableView: tableView, cellProvider: { tableView, indexPath, searchMovies in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchCell.reusableIdentifier, for: indexPath) as? SearchCell else {return UITableViewCell()
            }
            cell.set(searchMovies)
            return cell
        })
    }
    
    func updateSnopShot(_ searchMovies: [SearchMovies]) {
        var snopShot = NSDiffableDataSourceSnapshot<Sections, SearchMovies>()
        snopShot.appendSections([.main])
        snopShot.appendItems(searchMovies)
        DispatchQueue.main.async { [weak self] in
            guard let self else {return}
            dataSource.apply(snopShot, animatingDifferences: true)
        }
    }
}

extension SearchVC: SearchDelegate {
    func didReciveSearchMoviesData(_ decodedData: SearchMoviesData) {
        if movieName?.count ?? 0 >= 1 {
            movieDetailsArr = decodedData.results ?? []
            updateSnopShot(movieDetailsArr)
            DispatchQueue.main.async { [weak self] in
                guard let self else {return}
                    setNeedsUpdateContentUnavailableConfiguration()
            }
        }else {
            movieDetailsArr = []
            updateSnopShot(movieDetailsArr)
        }
    }
    
    func didFailureSearchMoviesData(_ error: String) {
        showError(title: "Search error", error: error)
    }
}

extension SearchVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        movieName = searchbar.text
        guard (searchbar.text?.isEmpty) != nil else {
            isSearching = false
            movieDetailsArr = []
            return
        }
        isSearching = true
        setNeedsUpdateContentUnavailableConfiguration()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        movieDetailsArr = []
        dismiss(animated: true)
    }
}

extension SearchVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieid = movieDetailsArr[indexPath.row].id ?? 0
        print(movieid)
        let detailVC = AllMovieDetailVC(movieID: movieid)
        navigationController?.pushViewController(detailVC, animated: true)
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        cell.showAnimation()
    }
    
}
