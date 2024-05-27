//
//  KeywordsModel.swift
//  Movies_App
//
//  Created by Kavin on 09/05/24.
//

import Foundation

struct KeywordData:Codable {
    let id: Int?
    let keywords: [Keywords]?
}

struct Keywords: Codable {
    let id: Int?
    let name: String?
}

struct KeywordMoviesListModel   : Codable {
    let id                      : Int?
    let page                    : Int?
    let results                 : [KeywordMoviesListData]?
    let totalPages              : Int?
    let totalResults            : Int?
    
}

struct KeywordMoviesListData    : Codable {
    let adult                   : Bool?
    let backdropPath            : String?
    let genreIds                : [Int]?
    let id                      : Int?
    let originalLanguage        : String?
    let originalTitle           : String?
    let overview                : String?
    let popularity              : Double?
    let posterPath              : String?
    let releaseDate             : String?
    let title                   : String?
    let video                   : Bool?
    let voteAverage             : Double?
    let voteCount               : Int?
    
    var posterPathsURL: URL? {
        return URL(string: Endpoints.getPosterPath(query: posterPath ?? ""))
    }
    
    var backDropPathURL: URL? {
        return URL(string: Endpoints.getbackDropPath(query: backdropPath ?? ""))
    }

}

