//
//  UpcomingMoviesVM.swift
//  Movies_App
//
//  Created by Kavin on 09/05/24.
//

import Foundation

protocol UpcomingMoviesDelegate {
    func didReciveUpcomingMoviesDatas(_ decodedData: UpcomingMovieDatas)
    func didFailureUpcomingMoviesData (_ error: String)
}

class UpcomingMoviesVM {
    var isLoading: Observable<Bool> = Observable(value: false)
    var client: HTTPClient?
    var delegate: UpcomingMoviesDelegate?
    
    init(client: HTTPClient, delegate: UpcomingMoviesDelegate) {
        self.client = client
        self.delegate = delegate
    }
    
    func getUpcomingDatas(page: Int) {
        isLoading.value = true
        client?.networking(endpoints: .getUpcomongMovies(number: page), competion: { [weak self]  result in
            guard let self else {return}
            isLoading.value = false
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let decodedData = try decoder.decode(UpcomingMovieDatas.self, from: data)
                    self.delegate?.didReciveUpcomingMoviesDatas(decodedData)
                }catch {
                    self.delegate?.didFailureUpcomingMoviesData(error.localizedDescription)
                }
            case .failure(let error):
                self.delegate?.didFailureUpcomingMoviesData(error.localizedDescription)
            }
        })
    }
}

