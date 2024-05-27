//
//  Endpoints.swift
//  Movies_App
//
//  Created by Kavin on 09/05/24.
//

import Foundation

struct Endpoints {
    let path: String
    let queryItems: [URLQueryItem]
}

extension Endpoints {
    var url: URL? {
        var components = URLComponents()
        components.scheme       = scheme
        components.host         = host
        components.path         = path
        components.queryItems   = queryItems
        return components.url
    }
    
    static func getPosterPath(query: String)->String {
        return posterPath + query
    }
    
    static func getbackDropPath(query: String)->String {
        return backDropPath + query
    }

    static func getURLQuery(pageNumber: Int = 1)->[URLQueryItem]{
        return [URLQueryItem(name: apiKey, value: SecretKeys.apikey),
                URLQueryItem(name: "include_adult", value: "false"),
                URLQueryItem(name: page, value: "\(pageNumber)"),
                URLQueryItem(name: "language", value: "en-US"),
                URLQueryItem(name: "append_to_response", value: "credits")
        ]
    }
    
    static func getMovies(number: Int)->Endpoints {
        Endpoints(path: moviePath, queryItems: getURLQuery(pageNumber: number))
    }
    
    static func getNowPlayingMovies(number: Int)->Endpoints {
        Endpoints(path: knowPlaying, queryItems: getURLQuery(pageNumber: number))
    }
    
    static func getTrendingMovies(number: Int)->Endpoints {
        Endpoints(path: kTrendingPath, queryItems: getURLQuery(pageNumber: number))
    }
    
    static func getUpcomongMovies(number: Int)->Endpoints {
        Endpoints(path: kupcomingPath, queryItems: getURLQuery(pageNumber: number))
    }
    
    static func getPopularMovies(number: Int)->Endpoints {
        Endpoints(path: kPopularPath, queryItems: getURLQuery(pageNumber: number))
    }
    
    static func getTopRatedMovies(number: Int)->Endpoints {
        Endpoints(path: kTopRatedPath, queryItems: getURLQuery(pageNumber: number))
    }
    
    static func getTVShows(number: Int)->Endpoints {
        Endpoints(path: kTVPath, queryItems: getURLQuery(pageNumber: number))
    }
    
    static func getMoviesDetail(id: Int)->Endpoints {
        Endpoints(path: kMovieDetail+"\(id)", queryItems: getURLQuery())
    }
    
    static func getMoviesReviews(id: Int)->Endpoints {
        Endpoints(path: kMovieDetail+"\(id)/"+kReviews, queryItems: getURLQuery())
    }
    
    static func getMoviesKeyword(id: Int)->Endpoints {
        Endpoints(path: kMovieDetail+"\(id)/"+kKeywords, queryItems: getURLQuery())
    }
    
    static func getVideos(id: Int)->Endpoints{
        return Endpoints(path: kMovieDetail+"\(id)"+kVideos, queryItems:getURLQuery())
    }
    
    static func getSimilerMovies(id: Int)-> Endpoints {
        return Endpoints(path: kMovieDetail+"\(id)"+kSimiler, queryItems: getURLQuery())
    }
    
    static func getPersonsCastDetails(personID: Int)-> Endpoints {
        return Endpoints(path: kPerson+"\(personID)", queryItems: getURLQuery())
    }
    
    static func getKeywordMoviesList(keywordID: Int)-> Endpoints {
        return Endpoints(path:kKeyword+"\(keywordID)"+kMovie, queryItems: getURLQuery())
    }
    
    static func getCompanyDetails(companyId: Int)->Endpoints {
        return Endpoints(path: kCompanyDetails+"\(companyId)", queryItems: getURLQuery())
    }
    
    static func getMoviePartOftheCollections(collectionId: Int)->Endpoints {
        return Endpoints(path: kCollections+"\(collectionId)", queryItems: getURLQuery())
    }
    
    static func searchMovies(movieName: String)->Endpoints {
        var query = getURLQuery()
        query.append(URLQueryItem(name: "query", value: movieName))
        return Endpoints(path: kSearchPath, queryItems: query)
    }
}

struct EndpointsOfYT {
    let path: String
}

extension EndpointsOfYT {
    var youeTubeUrl: URL? {
        var components = URLComponents()
        components.scheme       = youTubeScheme
        components.host         = youTubeHost
        components.path         = path
        return components.url
    }
    
    static func getYoutubeVideos(id: Int, videoKey: String?)-> EndpointsOfYT {
        return EndpointsOfYT(path: youTubePath+"\(id)"+(videoKey ?? ""))
    }
}
