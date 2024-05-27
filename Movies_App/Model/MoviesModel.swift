//
//  MoviesModel.swift
//  Movies_App
//
//  Created by Kavin on 09/05/24.
//

import Foundation


struct MoviesData: Codable {
    let page: Int
    let results: [Movies]?
    let totalPages: Int
    let totalResults: Int
}

struct Movies: Codable {
    let adult: Bool?
    let backdropPath: String?
    let genreIds: [Int]?
    let id: Int?
    let originalLanguage: String?
    let originalTitle: String?
    let overview: String?
    let popularity: Double?
    let posterPath: String?
    let releaseDate: String?
    let title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
    
    var posterPathUR: URL {
        return URL(string: Endpoints.getPosterPath(query: posterPath ?? ""))!
    }
    
    var backDropPathURLString: URL {
        return URL(string: Endpoints.getbackDropPath(query: posterPath ?? ""))!
    }
}
