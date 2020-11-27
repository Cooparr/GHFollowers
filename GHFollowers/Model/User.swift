//
//  User.swift
//  GHFollowers
//
//  Created by Alexander James Cooper on 27/11/2020.
//

import Foundation

struct User: Codable {
    let username: String
    let avatarURL: String
    let name: String?
    let location: String?
    let bio: String?
    let publicRepos: Int
    let publicGists: Int
    let htmlURL: String
    let following: Int
    let followers: Int
    let createdAt: String
    
    private enum CodingKeys: String, CodingKey {
        case username = "login"
        case avatarURL = "avatar_url"
        case name
        case location
        case bio
        case publicRepos = "public_repos"
        case publicGists = "public_gists"
        case htmlURL = "html_url"
        case following
        case followers
        case createdAt = "created_at"
    }
}
