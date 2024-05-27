//
//  SimilerVM.swift
//  Movies_App
//
//  Created by Kavin on 09/05/24.
//

import Foundation

protocol SimilerDelegate {
    func didReciveSimilerDatas(_ decodedData: SimilerData)
    func didFailureWithSimilerDatas(_ error: String)
}

class SimilerVM {
    
    var client: HTTPClient?
    var delegate: SimilerDelegate?
    var isLoading: Observable<Bool> = Observable(value: false)
    
    init(client: HTTPClient, delegate: SimilerDelegate) {
        self.client = client
        self.delegate = delegate
    }
    
    func getSimilerData(id: Int) {
        isLoading.value = true
        client?.networking(endpoints: .getSimilerMovies(id: id) ,competion: { [weak self]  result in
            guard let self else {return}
            isLoading.value = false
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let decodedData = try decoder.decode(SimilerData.self, from: data)
                    self.delegate?.didReciveSimilerDatas(decodedData)
                }catch {
                    self.delegate?.didFailureWithSimilerDatas(error.localizedDescription)
                }
            case .failure(let error):
                self.delegate?.didFailureWithSimilerDatas(error.localizedDescription)
            }
        })
    }
}


