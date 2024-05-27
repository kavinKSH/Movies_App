//
//  CompanyDetailsVM.swift
//  Movies_App
//
//  Created by Kavin on 18/05/24.
//

import Foundation

protocol CompanyDetailDelegate {
    func didReciveCompanyDetailsData(_ decodedData: CompanyDetails )
    func didFailuresCompanyDetailsData(_ error: String)
}

class CompanyDetailsVM {
    
    var client: HTTPClient?
    var delegate: CompanyDetailDelegate?
    var isloading: Observable = Observable(value: false)
    
    init(client: HTTPClient, delegate: CompanyDetailDelegate) {
        self.client = client
        self.delegate = delegate
    }
    
    func getCompanyDetailsData(id: Int) {
        isloading.value = true
        client?.networking(endpoints: .getCompanyDetails(companyId: id),competion: { [weak self]  result in
            guard let self else {return}
            isloading.value = false
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let decodedData = try decoder.decode(CompanyDetails.self, from: data)
                    self.delegate?.didReciveCompanyDetailsData(decodedData)
                }catch {
                    self.delegate?.didFailuresCompanyDetailsData(error.localizedDescription)
                }
            case .failure(let error):
                self.delegate?.didFailuresCompanyDetailsData(error.localizedDescription)
            }
        })
    }
}

