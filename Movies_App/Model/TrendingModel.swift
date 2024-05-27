//
//  TrendingModel.swift
//  Movies_App
//
//  Created by Kavin on 09/05/24.
//

import Foundation

struct TrendingMoviesModel   : Codable {
    let page                : Int?
    let results             : [TrendingMoviesData]
    let totalPages          : Int?
    let totalResults        : Int?
}

struct TrendingMoviesData   : Codable {
    let backdropPath        : String?
    let id                  : Int?
    let originalTitle       : String?
    let overview            : String?
    let posterPath          : String?
    let mediaType           : String?
    let adult               : Bool?
    let title               : String?
    let originalLanguage    : String?
    let genreIds            : [Int]?
    let popularity          : Double?
    let releaseDate         : String?
    let video               : Bool?
    let voteAverage         : Double?
    let voteCount           : Int?
    let name                : String?
    
    var posterPathURL: URL? {
        return URL(string: Endpoints.getPosterPath(query: posterPath ?? ""))
    }
    
    var backDropPathURL: URL? {
        return URL(string: Endpoints.getPosterPath(query: backdropPath ?? ""))
    }
}



