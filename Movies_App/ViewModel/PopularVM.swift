//
//  PopularVM.swift
//  Movies_App
//
//  Created by Kavin on 09/05/24.
//

import Foundation

protocol popularMoviesDelegate {
    func didRecivePopularDatas(_ decodedData: PopularMoviesData)
    func didFailurePopularDatas(_ error: String)
}

class PopularVM {
    
    var client: HTTPClient?
    var delegate: popularMoviesDelegate?
    var isLoading: Observable<Bool> = Observable(value: false)
    
    init(client: HTTPClient, delegate: popularMoviesDelegate) {
        self.client = client
        self.delegate = delegate
    }
    
    func getPopularDatas(page: Int) {
        isLoading.value = true
        client?.networking(endpoints: .getPopularMovies(number: page),competion: { [weak self]  result in
            guard let self else {return}
            isLoading.value = false
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let decodedData = try decoder.decode(PopularMoviesData.self, from: data)
                    self.delegate?.didRecivePopularDatas(decodedData)
                }catch {
                    self.delegate?.didFailurePopularDatas(error.localizedDescription)
                }
            case .failure(let error):
                self.delegate?.didFailurePopularDatas(error.localizedDescription)
            }
        })
    }
}

