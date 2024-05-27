//
//  SearchVM.swift
//  Movies_App
//
//  Created by Kavin on 09/05/24.
//

import Foundation

protocol SearchDelegate {
    func didReciveSearchMoviesData(_ decodedData: SearchMoviesData)
    func didFailureSearchMoviesData(_ error: String)
}

class SearchVM {
    
    var isLoading: Observable = Observable(value: false)
    var client: HTTPClient?
    var delegate: SearchDelegate?
    
    init(client: HTTPClient, delegate: SearchDelegate) {
        self.client = client
        self.delegate = delegate
    }
    
    func getSearchedMovies(movie: String) {
        isLoading.value = true
        client?.networking(endpoints: .searchMovies(movieName: movie) ,competion: { [weak self]  result in
            guard let self else {return}
            isLoading.value = false
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let decodedData = try decoder.decode(SearchMoviesData.self, from: data)
                    self.delegate?.didReciveSearchMoviesData(decodedData)
                }catch {
                    self.delegate?.didFailureSearchMoviesData(error.localizedDescription)
                }
            case .failure(let error):
                self.delegate?.didFailureSearchMoviesData(error.localizedDescription)
            }
        })
    }
}
