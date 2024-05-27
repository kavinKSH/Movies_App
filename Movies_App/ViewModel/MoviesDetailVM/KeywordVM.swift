//
//  KeywordVM.swift
//  Movies_App
//
//  Created by Kavin on 09/05/24.
//

import Foundation

protocol KeywordsDelegate {
    func didReciveKeywordMovies(_ decodedData: KeywordData)
    func didFailuresKeywordMovies(_ error: String)
}

class KeywordVM {
    
    var client: HTTPClient?
    var delegate: KeywordsDelegate?
    var isloading: Observable = Observable(value: false)
    
    init(client: HTTPClient, delegate: KeywordsDelegate) {
        self.client = client
        self.delegate = delegate
    }
    
    func getKeywordData(id: Int) {
        isloading.value = true
        client?.networking(endpoints: .getMoviesKeyword(id: id),competion: { [weak self]  result in
            guard let self else {return}
            isloading.value = false
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let decodedData = try decoder.decode(KeywordData.self, from: data)
                    self.delegate?.didReciveKeywordMovies(decodedData)
                }catch {
                    self.delegate?.didFailuresKeywordMovies(error.localizedDescription)
                }
            case .failure(let error):
                self.delegate?.didFailuresKeywordMovies(error.localizedDescription)
            }
        })
    }
}

