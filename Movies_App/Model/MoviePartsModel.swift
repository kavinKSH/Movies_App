//
//  MoviePartsModel.swift
//  Movies_App
//
//  Created by Kavin on 09/05/24.
//

import Foundation

struct CollectionData       : Codable {
    let id                  : Int?
    let name                : String?
    let overview            : String?
    let posterPath          : String?
    let backdropPath        : String?
    let parts               : [MovieParts]?
    
    var backdropPathURL: URL? {
        return URL(string: Endpoints.getPosterPath(query: backdropPath ?? ""))
    }
    
    var posterPathURL: URL? {
        return URL(string: Endpoints.getPosterPath(query: posterPath ?? ""))
    }
}

struct MovieParts           : Codable {
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
    
    var posterPathURL: URL? {
        return URL(string: Endpoints.getbackDropPath(query: posterPath ?? ""))
    }
    
    var backdropPathURL: URL? {
        return URL(string: Endpoints.getbackDropPath(query: backdropPath ?? ""))
    }
}
