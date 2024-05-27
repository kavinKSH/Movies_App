//
//  ReviewersVC.swift
//  Movies_App
//
//  Created by Kavin on 10/05/24.
//

import UIKit

class ReviewersVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var reviewerArr = [Reviwers]()
    
    init(reviewer: [Reviwers]) {
        super.init(nibName: "ReviewersVC", bundle: nil)
        self.reviewerArr = reviewer
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setuptableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.topItem?.backButtonDisplayMode = .minimal
        title = "Movies Reviews"
    }
    
    func setuptableView() {
        tableView.register(UINib(nibName: ReviewersListCell.reusableIdentifier, bundle: nil), forCellReuseIdentifier: ReviewersListCell.reusableIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension ReviewersVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviewerArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReviewersListCell.reusableIdentifier , for: indexPath) as? ReviewersListCell else {return UITableViewCell()}
        let reviewers = reviewerArr[indexPath.row]
        cell.set(reviewers)
        cell.selectionStyle = .none
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let title = reviewerArr[indexPath.row].author
        guard let reviewersVC = UIApplication.shared.firstKeyWindow?.rootViewController as? UINavigationController else {return}
        reviewersVC.title = title
        reviewersVC.pushViewController(ReviewersVC(reviewer: reviewerArr), animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
