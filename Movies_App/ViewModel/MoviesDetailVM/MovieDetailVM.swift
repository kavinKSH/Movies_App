//
//  MovieDetailVM.swift
//  Movies_App
//
//  Created by Kavin on 09/05/24.
//

import Foundation

enum MovieDetailsType {
    case poster
    case movieDetail
    case topCast
    case keywords
    case productionCompany
    case reviewers
    case videos
    case collections
    case similer
}

protocol MoviesDetailDelegate {
    func didReciveMoviesDetailData(_ decodedData: MoviesDetailData)
    func didFailureMoviesDetailData(_ error: String)
}

class MovieDetailVM {
    var client: HTTPClient?
    var delegate: MoviesDetailDelegate?
    var isLoading: Observable<Bool> = Observable(value: false)
    var isReciveDatas: Bool = true
    
    init(client: HTTPClient, delegate: MoviesDetailDelegate) {
        self.client = client
        self.delegate = delegate
    }
    
    func getMoviesDetail(id: Int) {
        isLoading.value = true
        client?.networking(endpoints: .getMoviesDetail(id: id),competion: { [weak self]  result in
            guard let self else {return}
            isLoading.value = false
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    let decodedData = try decoder.decode(MoviesDetailData.self, from: data)
                    self.delegate?.didReciveMoviesDetailData(decodedData)
                }catch {
                    self.delegate?.didFailureMoviesDetailData(error.localizedDescription)
                }
            case .failure(let error):
                self.delegate?.didFailureMoviesDetailData(error.localizedDescription)
            }
        })
    }
}
