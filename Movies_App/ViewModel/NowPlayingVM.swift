//
//  NowPlayingVM.swift
//  Movies_App
//
//  Created by Kavin on 09/05/24.
//

import Foundation

protocol NowPlayingMoviesDelegate {
    func didReciveSuccessWithNowPlayinData(of decodecData: NowPlayingMoviesData)
    func didFailuresWithNowPlayingData(of error: String)
}

class NowPlayingMoviesVM {
    var isLoading: Observable<Bool> = Observable(value: false)
    var client: HTTPClient?
    var delegate: NowPlayingMoviesDelegate?
    var pageNumber: Int = 1
    
    init(client: HTTPClient,delegate: NowPlayingMoviesDelegate) {
        self.client = client
        self.delegate = delegate
    }
 
    func getNowPlayingDatas(page: Int ) {
        isLoading.value = true
        client?.networking( endpoints: .getNowPlayingMovies(number: pageNumber), competion: { [weak self]
            result in
            self?.isLoading.value = false
            guard let self else {return}
            switch result {
            case .success(let nowPlayingData):
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let decodedData = try decoder.decode(NowPlayingMoviesData.self, from: nowPlayingData)
                    self.delegate?.didReciveSuccessWithNowPlayinData(of: decodedData)
                }catch {
                    self.delegate?.didFailuresWithNowPlayingData(of: error.localizedDescription)
                }
            case .failure(let error):
                self.delegate?.didFailuresWithNowPlayingData(of: error.localizedDescription)
            }
        })
    }
}
