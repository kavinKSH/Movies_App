//
//  TopRatedModel.swift
//  Movies_App
//
//  Created by Kavin on 09/05/24.
//

import Foundation

struct TopRatedMoviesData      : Codable {
    let dates               : TopRatedMoviesDate?
    let page                : Int?
    let results             : [TopRatedMovies]
    let totalPages          : Int?
    let totalResults        : Int?
}
    
struct TopRatedMoviesDate   : Codable {
    let maximum             : String?
    let minimum             : String?
}
    
struct TopRatedMovies       : Codable {
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
    
    var posterPathsURL: URL? {
        return URL(string: Endpoints.getPosterPath(query: posterPath!))
    }
    
    var backDropPathURL: URL? {
        return URL(string: Endpoints.getbackDropPath(query: backdropPath!))
    }
}
