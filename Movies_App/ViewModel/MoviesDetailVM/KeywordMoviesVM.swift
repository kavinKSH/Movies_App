//
//  KeywordMoviesVM.swift
//  Movies_App
//
//  Created by Kavin on 17/05/24.
//

import Foundation

protocol KeywordsMoviesDelegate {
    func didReciveKeywordMoviesListData(_ decodedData: KeywordMoviesListModel)
    func didFailuresKeywordMoviesListData(_ error: String)
}

class KeywordMoviesVM {
    
    var client: HTTPClient?
    var delegate: KeywordsMoviesDelegate?
    var isloading: Observable = Observable(value: false)
    
    init(client: HTTPClient, delegate: KeywordsMoviesDelegate) {
        self.client = client
        self.delegate = delegate
    }
    
    func getKeywordMoviesListData(id: Int, page: Int) {
        isloading.value = true
        client?.networking(endpoints: .getKeywordMoviesList(keywordID: id),competion: { [weak self]  result in
            guard let self else {return}
            isloading.value = false
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let decodedData = try decoder.decode(KeywordMoviesListModel.self, from: data)
                    self.delegate?.didReciveKeywordMoviesListData(decodedData)
                }catch {
                    self.delegate?.didFailuresKeywordMoviesListData(error.localizedDescription)
                }
            case .failure(let error):
                self.delegate?.didFailuresKeywordMoviesListData(error.localizedDescription)
            }
        })
    }
}

