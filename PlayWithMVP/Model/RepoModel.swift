//
//  RepoModel.swift
//  PlayWithMVP
//
//  Created by Abdelrhman Eliwa on 5/19/20.
//  Copyright © 2020 Abdelrhman Eliwa. All rights reserved.
//

import Foundation

struct RepoModel: Codable {
    let name: String
    let description: String?
    let owner: Owner?
    let avatarUrl: Owner?
}

struct Owner: Codable {
    let login: String?
    let avatarUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case login
        case avatarUrl = "avatar_url"
    }
}
