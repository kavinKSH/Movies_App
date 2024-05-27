//
//  MovieCastVm.swift
//  Movies_App
//
//  Created by Kavin on 09/05/24.
//

import Foundation

protocol MovieCastDelegate {
    func didReciveMovieCastDetailsData(_ decodedData: MovieCastPersonData)
    func didFailureWithMovieCastDetailsDatas(_ error: String)
}

class MovieCastVM {
    var isLoading: Observable<Bool> = Observable(value: false)
    var client: HTTPClient?
    var delegate: MovieCastDelegate?
    
    init(client: HTTPClient, delegate: MovieCastDelegate) {
        self.client = client
        self.delegate = delegate
    }
    
    func getMovieCastDatas(personID: Int) {
        isLoading.value = true
        client?.networking(endpoints: .getPersonsCastDetails(personID: personID) ,competion: { [weak self]  result in
            guard let self else {return}
            isLoading.value = false
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let decodedData = try decoder.decode(MovieCastPersonData.self, from: data)
                    self.delegate?.didReciveMovieCastDetailsData(decodedData)
                }catch {
                    self.delegate?.didFailureWithMovieCastDetailsDatas(error.localizedDescription)
                }
            case .failure(let error):
                self.delegate?.didFailureWithMovieCastDetailsDatas(error.localizedDescription)
            }
        })
    }
}


