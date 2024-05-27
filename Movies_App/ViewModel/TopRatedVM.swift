//
//  TopRatedVM.swift
//  Movies_App
//
//  Created by Kavin on 09/05/24.
//

import Foundation


protocol TopRatedMoviesDelegate {
    func didReciveTopRatedMoviesData(_ decodedData: TopRatedMoviesData)
    func didFailureTopRatedMoviesData(_ error: String)
}

class TopRatedVM {
    var client: HTTPClient?
    var delegate: TopRatedMoviesDelegate?
    var isLoading: Observable<Bool> = Observable(value: false)
    
    init(client: HTTPClient, delegate: TopRatedMoviesDelegate) {
        self.client = client
        self.delegate = delegate
    }
    
    func getTopRatedMoviesData(page: Int) {
        isLoading.value = true
        client?.networking(endpoints: .getTopRatedMovies(number: page),competion: { [weak self]  result in
            guard let self else {return}
            isLoading.value = false
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let decodedData = try decoder.decode(TopRatedMoviesData.self, from: data)
                    self.delegate?.didReciveTopRatedMoviesData(decodedData)
                }catch {
                    self.delegate?.didFailureTopRatedMoviesData(error.localizedDescription)
                }
            case .failure(let error):
                self.delegate?.didFailureTopRatedMoviesData(error.localizedDescription)
            }
        })
    }
}


