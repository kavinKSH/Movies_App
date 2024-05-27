//
//  DetailCell.swift
//  Movies_App
//
//  Created by Kavin on 16/05/24.
//

import UIKit
import SafariServices

class DetailCell: UITableViewCell {
    
    @IBOutlet weak var originalTitleLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var taglineLabel: UILabel!

    @IBOutlet weak var productionCountriesLabel: UILabel!
    @IBOutlet weak var budgetLabel: UILabel!
    @IBOutlet weak var revenueLabel: UILabel!
    @IBOutlet weak var adultLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var homePageLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    
    var homePage: String = ""
    let tap = UITapGestureRecognizer()

    static var reusableIdentfier: String {
        return String(describing: self)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(homePageLinkTapped))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        tap.addTarget(self, action: #selector(homePageLinkTapped))
        homePageLabel.isUserInteractionEnabled = true
    }
    
    @objc func homePageLinkTapped() {
        guard let url = URL(string: homePage) else {return}
        UIApplication.shared.open(url)
    }
    
    func set(_ datas: MoviesDetailData) {
        originalTitleLabel.text = datas.originalTitle ?? datas.title
        taglineLabel.text = datas.tagline
        
        let geners = datas.genres?.compactMap({$0.name})
        let convertArrToStr = geners?.joined(separator: " • ") ?? ""
        genreLabel.animatedText(for: " • \(convertArrToStr)")
        
        let country = datas.productionCountries?.compactMap({$0.name})
        let convertCompanyString = country?.joined(separator: ",")
        productionCountriesLabel.animatedTextWithTitle(title: "Country: ", for: convertCompanyString)
        
        let budget = datas.budget ?? 0
        budgetLabel.animatedTextWithTitle(title: "Total Budget: ", for: "\(budget)")
        
        let revenue = datas.revenue ?? 0
        revenueLabel.animatedTextWithTitle(title: "Total Revenue: ", for: "\(revenue)")
        
        let adult = datas.adult ?? false
        adult ? adultLabel.animatedTextWithTitle(title: "Adault: ", for: "Yes") : adultLabel.animatedTextWithTitle(title: "Adault: ", for: "No")
        
        let status = datas.status
        statusLabel.animatedTextWithTitle(title: "Status: ", for: status)
        
        homePageLabel.makeLink(title: "Homepage: ", for: datas.homepage)
        homePage = datas.homepage ?? ""
        
        let language = datas.spokenLanguages?.compactMap({$0.englishName})
        let languageToString = language?.joined(separator: ",")
        languageLabel.animatedTextWithTitle(title: "SpokenLanguages: ", for: languageToString)
        
        overviewLabel.animatedTextWithTitle(title: "Overview: ", for: datas.overview)
    }
}
