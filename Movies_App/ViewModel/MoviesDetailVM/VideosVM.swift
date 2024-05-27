//
//  VideosVM.swift
//  Movies_App
//
//  Created by Kavin on 09/05/24.
//

import Foundation

protocol VideosDelegate {
    func didReciveVideosData(_ decodedData: VideosData)
    func didFailureWithVideosData(_ error: String)
}

class VideosVM {
    var client: HTTPClient?
    var delegate: VideosDelegate?
    var isLoading: Observable<Bool> = Observable(value: false)

    init(client: HTTPClient, delegate: VideosDelegate) {
        self.client = client
        self.delegate = delegate
    }
    
    func getVideosData(id: Int) {
        isLoading.value = true
        client?.networking(endpoints: .getVideos(id: id),competion: { [weak self]  result in
            guard let self else {return}
            isLoading.value = false
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    let decodedData = try decoder.decode(VideosData.self, from: data)
                    self.delegate?.didReciveVideosData(decodedData)
                }catch {
                    self.delegate?.didFailureWithVideosData(error.localizedDescription)
                }
            case .failure(let error):
                self.delegate?.didFailureWithVideosData(error.localizedDescription)
            }
        })
    }
}

