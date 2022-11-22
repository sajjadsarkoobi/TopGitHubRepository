//
//  SearchRepositoryModel.swift
// TopRepo
//
//  Created by Sajjad Sarkoobi on 9.11.2022.
//

import Foundation

// MARK: - Search Repository Model
struct SearchRepositoryModel: Codable {
    let totalCount: Int
    let items: [RepositoryItemModel]

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case items
    }
}

// MARK: - Repository Item Model
struct RepositoryItemModel: Codable {
    let id: Int
    let name, fullName: String?
    let owner: OwnerModel
    let itemDescription: String?
    let stargazersCount: Int?
    let language: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case fullName = "full_name"
        case owner
        case itemDescription = "description"
        case stargazersCount = "stargazers_count"
        case language
    }
}

// MARK: - Owner Model
struct OwnerModel: Codable {
    let login: String?
    let id: Int
    let avatarURL: String?

    enum CodingKeys: String, CodingKey {
        case login, id
        case avatarURL = "avatar_url"
    }
}
