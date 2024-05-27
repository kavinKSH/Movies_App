//
//  AllCastListVC.swift
//  Movies_App
//
//  Created by Kavin on 10/05/24.
//

import UIKit

class AllCastListVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var castArr = [Cast]() {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self else {return}
                tableView.reloadData()
            }
        }
    }
    
    init(castArr: [Cast]) {
        super.init(nibName: "AllCastListVC", bundle: nil)
        self.castArr = castArr
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.topItem?.backButtonDisplayMode = .minimal
        title = "All Build Cast"
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: AllCastListCell.reusableIdentifier, bundle: nil), forCellReuseIdentifier: AllCastListCell.reusableIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension AllCastListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return castArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AllCastListCell.reusableIdentifier, for: indexPath) as? AllCastListCell else {return UITableViewCell()}
        let castDatas = castArr[indexPath.row]
        cell.set(castDatas)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let persondId = castArr[indexPath.row].id
        let name = castArr[indexPath.row].name
        let allCastDetailVC = AllCastDetailVC(personID: persondId ?? 0)
        navigationController?.pushViewController(allCastDetailVC, animated: true)
    }
}
