//
//  NowPlayingModel.swift
//  Movies_App
//
//  Created by Kavin on 09/05/24.
//

import Foundation

struct NowPlayingMoviesData : Codable {
    let dates               : Dates?
    let page                : Int?
    let results             : [NowPlayingMovies]
    let totalPages          : Int?
    let totalResults        :Int?
}

struct Dates                : Codable {
    let maximum             : String?
    let minimum             : String?
}
    
struct NowPlayingMovies     : Codable, Hashable {
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

    var posterPathsURLString: URL? {
        return URL(string: Endpoints.getPosterPath(query: posterPath ?? ""))
    }

    var backDropPathURLString: URL? {
        return URL(string: Endpoints.getbackDropPath(query: backdropPath ?? ""))
    }
}

