//
//  ProductionDetailsVC.swift
//  Movies_App
//
//  Created by Kavin on 10/05/24.
//

import UIKit

class ProductionDetailsVC: UIViewController {
    
    @IBOutlet weak var logoImageView        : UIImageView!
    @IBOutlet weak var companyNameLabel     : UILabel!
    @IBOutlet weak var headQuartersLabel    : UILabel!
    @IBOutlet weak var countryLabel         : UILabel!
    @IBOutlet weak var homePageLabel        : UILabel!
    
    var companyDetailVM                     : CompanyDetailsVM?
    var companyId                           : Int?
    var companyName                         : String?
    
    var companyDetails: CompanyDetails? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self else {return}
                configureUI(companyDetails!)
            }
        }
    }
    
    init(companyId: Int, companyName: String) {
        super.init(nibName: "ProductionDetailsVC", bundle: nil)
        self.companyId = companyId
        self.companyName = companyName
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        companyDetailVM = CompanyDetailsVM(client: HTTPClient(), delegate: self)
        companyDetailVM?.getCompanyDetailsData(id: companyId ?? 0)
        configureTapOnView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.topItem?.backButtonDisplayMode = .minimal
        title = companyName
    }
    
    func configureTapOnView() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(ProductionDetailsVC.linkLabelTapped))
        homePageLabel.isUserInteractionEnabled = true
        homePageLabel.addGestureRecognizer(tap)
    }
    
    @objc func linkLabelTapped() {
        homePageLabel.isUserInteractionEnabled = true
        guard let url = URL(string: companyDetails?.homepage ?? "" )else {return}
        UIApplication.shared.open(url)
    }
    
    private func configureUI(_ datas: CompanyDetails) {
        downloadCompanyLogo(url: datas.logoPathURL)
        companyNameLabel.text = datas.name
        countryLabel.text = datas.originCountry
        headQuartersLabel.text = datas.headquarters
        homePageLabel.makeLink(title: "Homepage: ", for: datas.homepage)
    }
    
    func downloadCompanyLogo(url: URL?) {
        HTTPClient.shared.downloadMoviesImages(url: companyDetails?.logoPathURL) { image in
            DispatchQueue.main.async { [weak self] in
                guard let self else {return}
                self.logoImageView.image = image
            }
        }
    }
}

extension ProductionDetailsVC: CompanyDetailDelegate {
    func didReciveCompanyDetailsData(_ decodedData: CompanyDetails) {
        companyDetails = decodedData
    }
    
    func didFailuresCompanyDetailsData(_ error: String) {
        showError(title: "Company details error", error: error)
        
    }
}
