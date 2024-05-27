//
//  ReviewersModel.swift
//  Movies_App
//
//  Created by Kavin on 09/05/24.
//

import Foundation

struct ReviwersData             : Codable {
    let id                      : Int?
    let page                    : Int?
    let results                 : [Reviwers]?
    let totalPages              : Int?
    let totalResults            : Int?
}

struct Reviwers                  : Codable {
    let author                  : String?
    let authorDetails           : AuthorDetails?
    let content                 : String?
    let createdAt               : String?
    let id                      : String?
    let updatedAt               : String?
    let url                     : String?
}

struct AuthorDetails            : Codable {
    let name                    : String?
    let username                : String?
    let avatarPath              : String?
    let rating                  : Double?
    
    var avatarPathURL: URL? {
        return URL(string: Endpoints.getPosterPath(query: avatarPath ?? ""))
    }
}

