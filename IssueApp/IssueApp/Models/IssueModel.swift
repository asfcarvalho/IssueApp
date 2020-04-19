//
//  IssueModel.swift
//  IssueApp
//
//  Created by Anderson F Carvalho on 17/04/20.
//  Copyright © 2020 asfcarvalho. All rights reserved.
//

import Foundation

struct IssueModel: Codable {
    let title: String?
    let state: String?
    let body: String?
    let url: String?
    let createdAt: String?
    let user: User?
    
    enum CodingKeys: String, CodingKey {
        case title, state, body, user
        case createdAt = "created_at"
        case url = "html_url"
    }
}

// MARK: - User
struct User: Codable {
    let avatarURL: String?
    
    enum CodingKeys: String, CodingKey {
        case avatarURL = "avatar_url"
    }
}
