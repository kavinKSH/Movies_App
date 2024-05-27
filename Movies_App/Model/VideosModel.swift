//
//  VideosModel.swift
//  Movies_App
//
//  Created by Kavin on 09/05/24.
//

import Foundation

struct VideosData : Codable {
    let id : Int?
    let results : [Videos]?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case results = "results"
    }
}

struct Videos : Codable {
    let iso6391 : String?
    let iso31661 : String?
    let name : String?
    let key : String?
    let site : String?
    let size : Int?
    let type : String?
    let official : Bool?
    let publishedAt : String?
    let id : String?

    enum CodingKeys: String, CodingKey {
        case iso6391 = "iso_639_1"
        case iso31661 = "iso_3166_1"
        case name = "name"
        case key = "key"
        case site = "site"
        case size = "size"
        case type = "type"
        case official = "official"
        case publishedAt = "published_at"
        case id = "id"
    }
}
