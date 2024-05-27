//
//  CollectionVC.swift
//  Movies_App
//
//  Created by Kavin on 10/05/24.
//

import UIKit

class CollectionVC: UIViewController {

    @IBOutlet weak var collectionTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var moviePartsArr = [MovieParts]()
    var colletions: CollectionData?
    var collectionVM: CollectionVM?
    
    var movieId: Int? = 0
    init(movieId: Int) {
        super.init(nibName: "CollectionVC", bundle: nil)
        self.movieId = movieId
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showActivityIndicatorAnimation()
        collectionVM = CollectionVM(client: HTTPClient(), delegate: self)
        collectionVM?.getPartOfCollectionData(collectionId: self.movieId ?? 0)
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.topItem?.backButtonDisplayMode = .minimal
        navigationController?.setNavigationBarHidden(false, animated: true)
        title = "Part of the Movie Collections"
    }
    
    func showActivityIndicatorAnimation() {
        collectionVM?.isLoading.bind({[weak self] isLoading in
            guard let self, let isLoading else {return}
            showActivityIndicator(isLoading: isLoading)
        })
    }
    
    func showActivityIndicator(isLoading: Bool?) {
        DispatchQueue.main.async { [weak self] in
            guard let self, let isLoading else {return}
            if isLoading {
                self.activityIndicator.startAnimating()
            }else {
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    func configureTableView() {
        collectionTableView.register(UINib(nibName: CollectionCell.reusableIdentifier, bundle: nil), forCellReuseIdentifier: CollectionCell.reusableIdentifier)
        collectionTableView.register(UINib(nibName: PartHeader.reusableIdentifier, bundle: nil), forHeaderFooterViewReuseIdentifier: PartHeader.reusableIdentifier)
        collectionTableView.dataSource = self
        collectionTableView.delegate = self
    }
}

extension CollectionVC: CollectionsDelegate {
    func didRecivePartOftheCollectionsData(_ decodedData: CollectionData) {
        showActivityIndicatorAnimation()
        colletions = decodedData
        moviePartsArr.append(contentsOf: decodedData.parts ?? [])
    }
    
    func didFailurePartOfTheCollectionData(_ error: String) {
        showActivityIndicatorAnimation()
        showError(title: "Parts of the collection error ", error: error)
    }
}


extension CollectionVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = collectionTableView.dequeueReusableHeaderFooterView(withIdentifier: PartHeader.reusableIdentifier) as? PartHeader else {return UITableViewHeaderFooterView()}
        headerView.backImageView.alpha = 0.6
        if let colletions = colletions {
            headerView.set(colletions)
        }
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 280
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    }
}

extension CollectionVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviePartsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = collectionTableView.dequeueReusableCell(withIdentifier: CollectionCell.reusableIdentifier, for: indexPath) as? CollectionCell else {return UITableViewCell()}
        let parts = moviePartsArr[indexPath.row]
        cell.set(parts)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieId = moviePartsArr[indexPath.row].id ?? 0
        let detailVC = AllMovieDetailVC(movieID: movieId)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
