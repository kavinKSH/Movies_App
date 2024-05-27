//
//  TVShowVM.swift
//  Movies_App
//
//  Created by Kavin on 09/05/24.
//

import Foundation

protocol TVShowsDelegate {
    func didReciveTVShowData(_ decodedData: TVModelDatas)
    func didFailureTVShowsData(_ error: String)
}

class TVShowVM {
    
    var client: HTTPClient?
    var delegate: TVShowsDelegate?
    var isLoading: Observable<Bool> = Observable(value: false)
    
    init(client: HTTPClient, delegate: TVShowsDelegate) {
        self.client = client
        self.delegate = delegate
    }
    
    func getTVShowDatas(page: Int) {
        isLoading.value = true
        client?.networking(endpoints: .getTVShows(number: page),competion: { [weak self]  result in
            guard let self else {return}
            isLoading.value = false
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let decodedData = try decoder.decode(TVModelDatas.self, from: data)
                    self.delegate?.didReciveTVShowData(decodedData)
                }catch {
                    self.delegate?.didFailureTVShowsData(error.localizedDescription)
                }
            case .failure(let error):
                self.delegate?.didFailureTVShowsData(error.localizedDescription)
            }
        })
    }
}

