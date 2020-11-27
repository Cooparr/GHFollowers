//
//  Follower.swift
//  GHFollowers
//
//  Created by Alexander James Cooper on 27/11/2020.
//

import Foundation

struct Follower: Codable {
    let username: String
    let avatarURL: String
    
    private enum CodingKeys: String, CodingKey {
        case username = "login"
        case avatarURL = "avatar_url"
    }
}
