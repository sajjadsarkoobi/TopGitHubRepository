//
//  APIParameters.swift
// TopRepo
//
//  Created by Sajjad Sarkoobi on 9.11.2022.
//

import Foundation

struct APIParameters {
    
    struct SearchParams: Encodable {
        enum SortBy: String, Encodable  {
            case stars = "stars"
            case forks = "forks"
            case helpWantedIssues = " help-wanted-issues"
            case updated = "updated"
        }
        
        enum Languages: String, Encodable {
            case all = "language"
            case go = "language:go"
            case swift = "language:swift"
            case python = "language:python"
        }
        
        var q: Languages
        var sort: SortBy?
        var per_page: Int?
    }
}
