//
//  APIRouter.swift
// TopRepo
//
//  Created by Sajjad Sarkoobi on 9.11.2022.
//

import Foundation

class APIRouter {}

//MARK: -GET Requests
extension APIRouter {
    
    // GET Search in repositories
    struct GetSearchRepository: Request {
        typealias ReturnType = SearchRepositoryModel
        var path: String = "/search/repositories"
        var method: HTTPMethod = .get
        var queryParams: [String : Any]?
        init( _ queryParams: APIParameters.SearchParams) {
            self.queryParams = queryParams.asDictionary
        }
    }
}

//MARK: -POST Requests
extension APIRouter {
    ///Adding all POST request here
}
