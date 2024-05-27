//
//  MoviesVM.swift
//  Movies_App
//
//  Created by Kavin on 09/05/24.
//

import Foundation


protocol MoviesDelegate {
    func didReciveSuccessWithMoviesData(of decodedData: MoviesData)
    func didReciveFailureWithMoviesData(of error: String)
}

class MoviesVM {
    var isLoading: Observable<Bool> = Observable(value: false)
    var client: HTTPClient?
    var delegate: MoviesDelegate?
    var pageNumber: Int = 1
    
    init(client: HTTPClient,delegate: MoviesDelegate) {
        self.client = client
        self.delegate = delegate
    }
    
    func getMovies(page: Int){
        isLoading.value = true
        client?.networking(endpoints: .getMovies(number: page), competion: { [weak self] result in
            guard let self else {return}
            isLoading.value = false
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let decodedData = try decoder.decode(MoviesData.self, from: data)
                    self.delegate?.didReciveSuccessWithMoviesData(of: decodedData)
                }catch {
                    self.delegate?.didReciveFailureWithMoviesData(of: error.localizedDescription)
                }
            case .failure(let error):
                self.delegate?.didReciveFailureWithMoviesData(of: error.localizedDescription)
            }
        })
    }
    
    
}





