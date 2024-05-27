//
//  AllCastDetailVC.swift
//  Movies_App
//
//  Created by Kavin on 16/05/24.
//

import UIKit

class AllCastDetailVC: UIViewController {
    
    
    @IBOutlet weak var activityIndicator        : UIActivityIndicatorView!
    @IBOutlet weak var facebookView             : UIView!
    @IBOutlet weak var twitterView              : UIView!
    @IBOutlet weak var instaView                : UIView!
    @IBOutlet weak var profilecontainerView     : UIView!
 
    @IBOutlet weak var faceBookImageView        : UIImageView!
    @IBOutlet weak var twitterImageView         : UIImageView!
    @IBOutlet weak var instaImageView           : UIImageView!
    
    @IBOutlet weak var nameLabel                : UILabel!
    @IBOutlet weak var alsoKnowAsLabel          : UILabel!
    @IBOutlet weak var departmentLabel          : UILabel!
    @IBOutlet weak var bdayLabel                : UILabel!
    @IBOutlet weak var genderLabel              : UILabel!
    @IBOutlet weak var birthPlace               : UILabel!
    @IBOutlet weak var papularity               : UILabel!
    @IBOutlet weak var biographyLabel           : UILabel!
    
    @IBOutlet weak var profileImageView         : UIImageView!
    @IBOutlet weak var profileBackgroundImage   : UIImageView!
    @IBOutlet weak var profileBackgroundView    : UIView!
    
    var movieCastVM     : MovieCastVM?
    var personID        : Int?
    var personName      : String = ""
    
    var personDetails: MovieCastPersonData? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self else {return}
                configureUI()
                downLoadImages()
            }
        }
    }
    
    init(personID: Int) {
        super.init(nibName: "AllCastDetailVC", bundle: nil)
        self.personID = personID
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showActivityIndicatorAnimation()
        movieCastVM = MovieCastVM(client: HTTPClient(), delegate: self)
        movieCastVM?.getMovieCastDatas(personID: personID ?? 0)
        configureLayouts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.topItem?.backButtonDisplayMode = .minimal
    }
    
    func showActivityIndicatorAnimation() {
        movieCastVM?.isLoading.bind({ [weak self] isLoading in
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

    private func configureUI() {
        let name = personDetails?.name
        nameLabel.text = name
        title = name ?? "Cast Details"

        let alsoKnownAs = personDetails?.alsoKnownAs
        let alsoKnownAsString = alsoKnownAs?.joined(separator: ",")
        alsoKnowAsLabel.animatedTextWithTitle(title: "Also Known As: ", for: alsoKnownAsString)
        
        let knownForDepartment = personDetails?.knownForDepartment
        departmentLabel.animatedTextWithTitle(title: "Known For: ", for: knownForDepartment)
        
        let birthday = personDetails?.birthday
        bdayLabel.animatedTextWithTitle(title: "BirthDay: ", for: birthday)
        
        genderLabel.animatedTextWithTitle(title: "Gender: ", for: getGender())
        let placeOfBirth = personDetails?.placeOfBirth
        birthPlace.animatedTextWithTitle(title: "Place of Birth: ", for: placeOfBirth)
        
        let popularity = personDetails?.popularity ?? 0
        let ppopularityConvertString = String(format: "%.1f", popularity)
        papularity.animatedTextWithTitle(title: "Popularity: ", for: ppopularityConvertString)
        
        let biography = personDetails?.biography
        biographyLabel.animatedTextWithTitle(title: "Biography: ", for: biography)
    }
    
    func downLoadImages() {
        HTTPClient.shared.downloadMoviesImages(url: personDetails?.profilePathURL) { image in
            DispatchQueue.main.async { [weak self] in
                guard let self else{return}
                profileImageView.image = image
                profileBackgroundImage.image = image
            }
        }
    }
    
    private func getGender()->String {
        if personDetails?.gender == 0 {
            return "Male"
        }else if personDetails?.gender == 1 {
            return "Female"
        }else {
            return "Not Mentioned"
        }
    }
    
    private func configureLayouts() {
        profilecontainerView.layer.cornerRadius = 10
        profilecontainerView.layer.borderColor = UIColor.white.withAlphaComponent(0.5).cgColor
        profilecontainerView.layer.shadowOpacity = 0.2
        profilecontainerView.layer.shadowRadius  = 10
        profilecontainerView.layer.borderWidth = 1
        profilecontainerView.layer.masksToBounds = true
    }
}

extension AllCastDetailVC: MovieCastDelegate {
    func didReciveMovieCastDetailsData(_ decodedData: MovieCastPersonData) {
        personDetails = decodedData
        showActivityIndicatorAnimation()
    }
    
    func didFailureWithMovieCastDetailsDatas(_ error: String) {
        showError(title: "Persons details error", error: error)
        showActivityIndicatorAnimation()
    }
}
