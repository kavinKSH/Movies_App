//
//  PersonMediaTypeVC.swift
//  Movies_App
//
//  Created by Kavin on 10/05/24.
//

import UIKit

class PersonMediaTypeVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var castArr = [CastDetails]()
    var crewArr = [CrewDetails]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: PersonMediaTypeCell.reusableIdentifier, bundle: nil), forCellReuseIdentifier: PersonMediaTypeCell.reusableIdentifier)
        tableView.dataSource = self
        tableView.delegate   = self
        
        
    }
    
}

extension PersonMediaTypeVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PersonMediaTypeCell.reusableIdentifier, for: indexPath) as? PersonMediaTypeCell else {return UITableViewCell()}
        return cell
    }
}

