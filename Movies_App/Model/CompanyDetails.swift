//
//  CompanyDetails.swift
//  Movies_App
//
//  Created by Kavin on 18/05/24.
//

import Foundation

struct CompanyDetails: Codable {
    let description : String?
    let headquarters : String?
    let homepage : String?
    let id : Int?
    let logoPath : String?
    let name : String?
    let originCountry : String?
    let parentCompany : ParentCompany?
    
    var logoPathURL: URL? {
        return URL(string: Endpoints.getPosterPath(query: logoPath ?? ""))
    }
}

struct ParentCompany: Codable {
    let name: String?
    let id: Int?
    let logoPath : String?
}

