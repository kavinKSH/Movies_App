//
//  CollectionsVM.swift
//  Movies_App
//
//  Created by Kavin on 09/05/24.
//

import Foundation

protocol CollectionsDelegate {
    func didRecivePartOftheCollectionsData(_ decodedData: CollectionData)
    func didFailurePartOfTheCollectionData(_ error: String)
}

class CollectionVM {
    
    var client: HTTPClient?
    var delegate: CollectionsDelegate?
    var isLoading: Observable<Bool> = Observable(value: false)
    
    init(client: HTTPClient, delegate: CollectionsDelegate) {
        self.client = client
        self.delegate = delegate
    }
    
    func getPartOfCollectionData(collectionId: Int) {
        isLoading.value = true
        client?.networking(endpoints: .getMoviePartOftheCollections(collectionId: collectionId) ,competion: { [weak self]  result in
            guard let self else {return}
            isLoading.value = false
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let decodedData = try decoder.decode(CollectionData.self, from: data)
                    self.delegate?.didRecivePartOftheCollectionsData(decodedData)
                }catch {
                    self.delegate?.didFailurePartOfTheCollectionData(error.localizedDescription)
                }
            case .failure(let error):
                self.delegate?.didFailurePartOfTheCollectionData(error.localizedDescription)
            }
        })
    }
}


