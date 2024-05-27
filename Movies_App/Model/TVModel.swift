//
//  TVModel.swift
//  Movies_App
//
//  Created by Kavin on 09/05/24.
//

import Foundation

struct TVModelDatas         : Codable {
    let page                : Int?
    let results             : [TVDatas]
    let totalPages          : Int?
    let totalResults        : Int?
}

struct TVDatas              : Codable {
    let adult               : Bool?
    let backdropPath        : String?
    let genreIds            : [Int]?
    let id                  : Int?
    let originCountry       : [String]?
    let originalLanguage    : String?
    let originalName        : String?
    let overview            : String?
    let popularity          : Double?
    let posterPath          : String?
    let firstAirDate        : String?
    let name                : String?
    let voteAverage         : Double?
    let voteCount           : Int?
    
    var posterPathsURL: URL? {
        return URL(string: Endpoints.getPosterPath(query: posterPath!))
    }
    
    var backDropPathURL: URL? {
        return URL(string: Endpoints.getbackDropPath(query: backdropPath!))
    }
}


