//
//  MoviesCastPersonModel.swift
//  Movies_App
//
//  Created by Kavin on 09/05/24.
//

import Foundation

struct MovieCastPersonData          : Codable {
    let adult                       : Bool?
    let alsoKnownAs                 : [String]?
    let biography                   : String?
    let birthday                    : String?
    let deathday                    : String?
    let gender                      : Int?
    let homepage                    : String?
    let id                          : Int?
    let imdbId                      : String?
    let knownForDepartment          : String?
    let name                        : String?
    let placeOfBirth                : String?
    let popularity                  : Double?
    let profilePath                 : String?
    let credits                     : CreditsDetails?
    
    enum CodingKeys                 : String, CodingKey {
        case adult                  = "adult"
        case alsoKnownAs            = "also_known_as"
        case biography              = "biography"
        case birthday               = "birthday"
        case deathday               = "deathday"
        case gender                 = "gender"
        case homepage               = "homepage"
        case id                     = "id"
        case imdbId                 = "imdb_id"
        case knownForDepartment     = "known_for_department"
        case name                   = "name"
        case placeOfBirth           = "place_of_birth"
        case popularity             = "popularity"
        case profilePath            = "profile_path"
        case credits                = "credits"
    }
    
    var profilePathURL: URL? {
        return URL(string: Endpoints.getPosterPath(query: profilePath ?? ""))
    }
}

struct CreditsDetails               : Codable {
    let cast                        : [CastDetails]?
    let crew                        : [CrewDetails]?
    
    enum CodingKeys                 : String, CodingKey {
        case cast                   = "cast"
        case crew                   = "crew"
    }
}


struct CastDetails                   : Codable {
    let adult                        : Bool?
    let backdropPath                 : String?
    let genreIds                     : [Int]?
    let id                           : Int?
    let originalLanguage             : String?
    let originalTitle                : String?
    let overview                     : String?
    let popularity                   : Double?
    let posterPath                   : String?
    let releaseDate                  : String?
    let title                        : String?
    let video                        : Bool?
    let voteAverage                  : Double?
    let voteCount                    : Int?
    let character                    : String?
    let creditId                     : String?
    let order                        : Int?
    
    enum CodingKeys                  : String, CodingKey {
        case adult                   = "adult"
        case backdropPath           = "backdrop_path"
        case genreIds                = "genre_ids"
        case id                      = "id"
        case originalLanguage        = "original_language"
        case originalTitle           = "original_title"
        case overview                = "overview"
        case popularity              = "popularity"
        case posterPath              = "poster_path"
        case releaseDate             = "release_date"
        case title                   = "title"
        case video                   = "video"
        case voteAverage             = "vote_average"
        case voteCount               = "vote_count"
        case character               = "character"
        case creditId                = "credit_id"
        case order                   = "order"
    }
    
    var posterPathURL: URL? {
        return URL(string: Endpoints.getPosterPath(query: posterPath ?? ""))
    }
    var backdropPathURL: URL? {
        return URL(string: Endpoints.getbackDropPath(query: backdropPath ?? ""))
    }
}

struct CrewDetails                  : Codable {
    let adult                       : Bool?
    let backdropPath                : String?
    let genreIds                    : [Int]?
    let id                          : Int?
    let originalLanguage            : String?
    let originalTitle               : String?
    let overview                    : String?
    let popularity                  : Double?
    let posterPath                  : String?
    let releaseDate                 : String?
    let title                       : String?
    let video                       : Bool?
    let voteAverage                 : Double?
    let voteCount                   : Int?
    let creditId                    : String?
    let department                  : String?
    let job                         : String?
    
    enum CodingKeys                 : String, CodingKey {
        case adult                  = "adult"
        case backdropPath           = "backdrop_path"
        case genreIds               = "genre_ids"
        case id                     = "id"
        case originalLanguage       = "original_language"
        case originalTitle          = "original_title"
        case overview               = "overview"
        case popularity             = "popularity"
        case posterPath             = "poster_path"
        case releaseDate            = "release_date"
        case title                  = "title"
        case video                  = "video"
        case voteAverage            = "vote_average"
        case voteCount              = "vote_count"
        case creditId               = "credit_id"
        case department             = "department"
        case job                    = "job"
    }
}






