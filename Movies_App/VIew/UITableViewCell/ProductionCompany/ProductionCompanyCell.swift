//
//  ProductionCompanyCell.swift
//  Movies_App
//
//  Created by Kavin on 10/05/24.
//

import UIKit

class ProductionCompanyCell: UITableViewCell {
    
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var productionArr = [ProductionCompanies]() {
        didSet {
            DispatchQueue.main.async {[weak self] in
                guard let self else{return}
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
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setUpCollectionViewCell()
    }
    
    func setProductionCompanyDatas(_ datas: [ProductionCompanies]){
        productionArr = datas
    }
    
    func setUpCollectionViewCell() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = .init(top: 0, left: 0, bottom: 0, right: 10)
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.scrollDirection = .horizontal
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        collectionView.collectionViewLayout = flowLayout
        
        collectionView.register(UINib(nibName: ProductionCollectionCell.reusableIdentifier, bundle: nil), forCellWithReuseIdentifier: ProductionCollectionCell.reusableIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension ProductionCompanyCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productionArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductionCollectionCell.reusableIdentifier, for: indexPath) as? ProductionCollectionCell else {return UICollectionViewCell()}
        let name = productionArr[indexPath.item].name
        cell.companyLabel.text = name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let companyId = productionArr[indexPath.row].id
        let companyName = productionArr[indexPath.row].name
        guard let navigation = UIApplication.shared.firstKeyWindow?.rootViewController as? UINavigationController else {return}
        let companyDetailVC = ProductionDetailsVC(companyId: companyId ?? 0, companyName: companyName ?? "")
        navigation.pushViewController(companyDetailVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        showAnimation()
    }
}






