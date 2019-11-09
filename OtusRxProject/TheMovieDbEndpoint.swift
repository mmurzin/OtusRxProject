//
//  TheMovieDb.swift
//  OtusRxProject
//
//  Created by Murzin Mikhail on 04.11.2019.
//  Copyright © 2019 Murzin Mikhail. All rights reserved.
//

import Foundation

enum TheMovieDbEndpoint {
    static let base = "https://api.themoviedb.org/3"
    private static let API_KEY = "9329692b141f3570a525b0207ffbc757"

    case search(_ q: String)

    var url: URL {
        switch self {
        case .search(let q):
            let queryItems = [
                NSURLQueryItem(name: "api_key", value: TheMovieDbEndpoint.API_KEY),
                NSURLQueryItem(name: "language", value: "en"),
                NSURLQueryItem(name: "query", value: q)]
            let urlComps = NSURLComponents(string: "\(TheMovieDbEndpoint.base)/search/movie")!
            urlComps.queryItems = queryItems as [URLQueryItem]
            return urlComps.url!
        }
    }
}
