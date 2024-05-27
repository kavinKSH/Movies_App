//
//  TrendingVM.swift
//  Movies_App
//
//  Created by Kavin on 09/05/24.
//

import Foundation

protocol TrendingMoviesDelegate {
    func didSuccessWithTrendingMoviesData(_ decodedData: TrendingMoviesModel)
    func didFailureWithTrendingMoviesData(_ error: String)
}

class TrendingVM {
    var client: HTTPClient?
    var delegate: TrendingMoviesDelegate?
    var isLoading: Observable<Bool> = Observable(value: false)
    
    init(client: HTTPClient, delegate: TrendingMoviesDelegate) {
        self.client = client
        self.delegate = delegate
    }
    
    func getTrendingMoviesDatas(page: Int) {
        isLoading.value = true
        client?.networking(endpoints: .getTrendingMovies(number: page), competion: { [weak self] result in
            guard let self else { return }
            isLoading.value = false
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let decodedData = try decoder.decode(TrendingMoviesModel.self, from: data)
                    self.delegate?.didSuccessWithTrendingMoviesData(decodedData)
                }catch {
                    self.delegate?.didFailureWithTrendingMoviesData(error.localizedDescription)
                }
            case .failure(let error):
                self.delegate?.didFailureWithTrendingMoviesData(error.localizedDescription)
            }
        })
    }
}
