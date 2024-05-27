//
//  UpComingModel.swift
//  Movies_App
//
//  Created by Kavin on 09/05/24.
//

import Foundation


struct UpcomingMovieDatas   : Codable {
    
    let dates               : DatesOfUpcoming?
    let page                : Int?
    let results             : [UpcomingMovies]
    let total_pages         : Int?
    let total_results       : Int?
}

struct UpcomingMovies       : Codable {
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
        return URL(string: Endpoints.getPosterPath(query: posterPath ?? ""))
    }
    
    var backDropPathURL: URL? {
        return URL(string: Endpoints.getPosterPath(query: backdropPath ?? ""))
    }
}

struct DatesOfUpcoming      : Codable {
    let maximum             : String?
    let minimum             : String?
}
