//
//  RepositoryDetailsCellViewModel.swift
// TopRepo
//
//  Created by Sajjad Sarkoobi on 10.11.2022.
//

import Foundation

class RepositoryDetailsCellViewModel {
    
    var id: Int
    var name: String
    var fullName: String
    var avatar: String
    var description: String
    var language: String
    var stars: String
    
    init(repositoryData: RepositoryItemModel) {
        self.id = repositoryData.id
        self.name = repositoryData.name ?? "..."
        self.fullName = repositoryData.fullName ?? "..."
        self.avatar = repositoryData.owner.avatarURL ?? ""
        self.description = repositoryData.itemDescription ?? "..."
        self.language = repositoryData.language ?? "UnKnown"
        self.stars = ("\(repositoryData.stargazersCount ?? 0)")
    }
}
