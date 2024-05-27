//
//  SearchModel.swift
//  Movies_App
//
//  Created by Kavin on 09/05/24.
//

import Foundation

struct SearchMoviesData     : Codable, Hashable {
    let page                : Int?
    let results             : [SearchMovies]?
    let totalPages          : Int?
    let totalResults        : Int?
}

struct SearchMovies         : Codable, Hashable {
    let adult               : Bool?
    let backdropPath        : String?
    let genreIds            : [Int]?
    let id                  : Int?
    let originalLanguage    : String?
    let originalTitle       : String?
    let overview            : String?
    let popularity          : Double?
    let posterPath          : String?
    let releaseDate         : String?
    let title               : String?
    let video               : Bool?
    let voteAverage         : Double?
    let voteCount           : Int?
    
    var posterPathURL: URL? {
        return URL(string: Endpoints.getbackDropPath(query: posterPath ?? ""))
    }
    
    var backdropPathURL: URL? {
        return URL(string: Endpoints.getbackDropPath(query: backdropPath ?? ""))
    }
}
