//
//  TheMovieDbService.swift
//  OtusRxProject
//
//  Created by Murzin Mikhail on 04.11.2019.
//  Copyright © 2019 Murzin Mikhail. All rights reserved.
//

import Foundation

class TheMovieDbService {
    func searchMovies(_ q: String, completion: @escaping ([Movie]?, Error?) -> ()) {
        let url = TheMovieDbEndpoint.search(q).url
        print(url)
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                return
            }
            print(data)
            do {
                let searchResult = try JSONDecoder().decode(SearchResponse.self, from: data)
                completion(searchResult.results, nil)
            } catch {
                print("error")
                completion(nil, error)
            }
        }.resume()
    }
}
