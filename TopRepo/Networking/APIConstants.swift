//
//  APIConstants.swift
// TopRepo
//
//  Created by Sajjad Sarkoobi on 9.11.2022.
//

import Foundation

final class APIConstants {
    static var baseURL = "https://api.github.com"
}

enum HTTPHeaderField: String {
    case authentication = "Authentication"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
    case authorization = "Authorization"
    case acceptLanguage = "Accept-Language"
    case userAgent = "User-Agent"
}

enum ContentType: String {
    case json = "application/json"
    case xwwwformurlencoded = "application/x-www-form-urlencoded"
}

enum Authentication:String {
    case api_key = ""
}
