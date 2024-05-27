//
//  ReviewersVM.swift
//  Movies_App
//
//  Created by Kavin on 09/05/24.
//

import Foundation

protocol ReviwersDelegate {
    func didReciveReviwersComments(_ decodedData: ReviwersData)
    func didFailureMovieReviewersData(_ error: String)
}

class ReviwersVM {
    
    var client: HTTPClient?
    var delegate: ReviwersDelegate?
    var isLoading: Observable<Bool> = Observable(value: false)
    init(client: HTTPClient, delegate: ReviwersDelegate) {
        self.client = client
        self.delegate = delegate
    }
    
    func getReviwersData(id: Int) {
        isLoading.value = true
        client?.networking(endpoints: .getMoviesReviews(id: id),competion: { [weak self]  result in
            guard let self else {return}
            isLoading.value = false
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let decodedData = try decoder.decode(ReviwersData.self, from: data)
                    self.delegate?.didReciveReviwersComments(decodedData)
                }catch {
                    self.delegate?.didFailureMovieReviewersData(error.localizedDescription)
                }
            case .failure(let error):
                self.delegate?.didFailureMovieReviewersData(error.localizedDescription)
            }
        })
    }
}

