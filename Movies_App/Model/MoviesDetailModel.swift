//
//  MoviesDetailModel.swift
//  Movies_App
//
//  Created by Kavin on 09/05/24.
//

import Foundation

struct MoviesDetailData             : Codable {
    let adult                       : Bool?
    let backdropPath                : String?
    let belongsToCollection         : BelongsToCollection?
    let budget                      : Int?
    let genres                      : [Genres]?
    let homepage                    : String?
    let id                          : Int?
    let imdbId                      : String?
    let originCountry               : [String]?
    let originalLanguage            : String?
    let originalTitle               : String?
    let overview                    : String?
    let popularity                  : Double?
    let posterPath                  : String?
    let productionCompanies         : [ProductionCompanies]?
    let productionCountries         : [ProductionCountries]?
    let releaseDate                 : String?
    let revenue                     : Int?
    let runtime                     : Int?
    let spokenLanguages             : [SpokenLanguages]?
    let status                      : String?
    let tagline                     : String?
    let title                       : String?
    let video                       : Bool?
    let voteAverage                 : Double?
    let voteCount                   : Int?
    let credits                     : Credits?
    
    
    enum CodingKeys: String, CodingKey {
        
        case adult                 = "adult"
        case backdropPath          = "backdrop_path"
        case belongsToCollection   = "belongs_to_collection"
        case budget                = "budget"
        case genres                = "genres"
        case homepage              = "homepage"
        case id                    = "id"
        case imdbId                = "imdb_id"
        case originCountry         = "origin_country"
        case originalLanguage      = "original_language"
        case originalTitle         = "original_title"
        case overview              = "overview"
        case popularity            = "popularity"
        case posterPath            = "poster_path"
        case productionCompanies   = "production_companies"
        case productionCountries   = "production_countries"
        case releaseDate           = "release_date"
        case revenue               = "revenue"
        case runtime               = "runtime"
        case spokenLanguages       = "spoken_languages"
        case status                = "status"
        case tagline               = "tagline"
        case title                 = "title"
        case video                 = "video"
        case voteAverage           = "vote_average"
        case voteCount             = "vote_count"
        case credits               = "credits"
    }
    
    var backDropPathURL: URL? {
        return URL(string: Endpoints.getbackDropPath(query: backdropPath ?? ""))
    }
    
    var posterPathURL: URL? {
        return URL(string: Endpoints.getbackDropPath(query: posterPath ?? ""))
    }
}

struct BelongsToCollection: Codable {
    let id                          : Int?
    let name                        : String?
    let posterPath                  : String?
    let backdropPath                : String?
    
    enum CodingKeys: String, CodingKey {
        case id                     = "id"
        case name                   = "name"
        case posterPath             = "poster_path"
        case backdropPath           = "backdrop_path"
    }
}

struct Genres                       : Codable {
    let id                          : Int?
    let name                        : String?
    
    enum CodingKeys                 : String, CodingKey {
        case id                     = "id"
        case name                   = "name"
    }
}

struct ProductionCompanies          : Codable {
    let id                          : Int?
    let logoPath                    : String?
    let name                        : String?
    let originCountry               : String?
    
    enum CodingKeys: String, CodingKey {
        case id                     = "id"
        case logoPath               = "logo_path"
        case name                   = "name"
        case originCountry          = "origin_country"
    }
}

struct ProductionCountries          : Codable {
    let iso31661                    : String?
    let name                        : String?
    
    enum CodingKeys                 : String, CodingKey {
        case iso31661               = "iso_3166_1"
        case name                   = "name"
    }
}

struct SpokenLanguages              : Codable {
    let englishName                 : String?
    let iso6391                     : String?
    let name                        : String?
    
    enum CodingKeys                 : String, CodingKey {
        case englishName            = "english_name"
        case iso6391                = "iso_639_1"
        case name                   = "name"
    }
}

struct Credits                      : Codable {
    let cast                        : [Cast]?
    let crew                        : [Crew]?
    
    enum CodingKeys                 : String, CodingKey {
        case cast                   = "cast"
        case crew                   = "crew"
    }
}

struct Cast                         : Codable {
    let adult                       : Bool?
    let gender                      : Int?
    let id                          : Int?
    let knownForDepartment          : String?
    let name                        : String?
    let originalName                : String?
    let popularity                  : Double?
    let profilePath                 : String?
    let castId                      : Int?
    let character                   : String?
    let creditId                    : String?
    let order                       : Int?
    
    enum CodingKeys                 : String, CodingKey {
        case adult                  = "adult"
        case gender                 = "gender"
        case id                     = "id"
        case knownForDepartment     = "known_for_department"
        case name                   = "name"
        case originalName           = "original_name"
        case popularity             = "popularity"
        case profilePath            = "profile_path"
        case castId                 = "cast_id"
        case character              = "character"
        case creditId               = "credit_id"
        case order                  = "order"
    }
    
    var profilePathURL: URL? {
        return URL(string: Endpoints.getPosterPath(query: profilePath ?? ""))
    }
}

struct Crew                         : Codable {
    let adult                       : Bool?
    let gender                      : Int?
    let id                          : Int?
    let knownForDepartment          : String?
    let name                        : String?
    let originalName                : String?
    let popularity                  : Double?
    let profilePath                 : String?
    let creditId                    : String?
    let department                  : String?
    let job                         : String?
    
    enum CodingKeys: String, CodingKey {
        
        case adult                  = "adult"
        case gender                 = "gender"
        case id                     = "id"
        case knownForDepartment     = "known_for_department"
        case name                   = "name"
        case originalName           = "original_name"
        case popularity             = "popularity"
        case profilePath            = "profile_path"
        case creditId               = "credit_id"
        case department             = "department"
        case job                    = "job"
    }
}

