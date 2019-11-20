//
//  TheMovieDbService.swift
//  OtusRxProject
//
//  Created by Murzin Mikhail on 04.11.2019.
//  Copyright © 2019 Murzin Mikhail. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class TheMovieDbService {
    
    private let movieDetailSubjectData : PublishSubject<DetailMovie?> = PublishSubject()
    
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
    
    func getMovieDetail(_ id: Int) -> PublishSubject<DetailMovie?> {
        let url = TheMovieDbEndpoint.detail(id).url
        print(url)
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let responseError = error{
                self.movieDetailSubjectData.onError(responseError)
                return
            }
            guard let data = data else {
                return
            }
            print(data)
            do {
                let detailMovieResult = try JSONDecoder().decode(DetailMovie.self, from: data)
                self.movieDetailSubjectData.onNext(detailMovieResult)
            } catch {
                self.movieDetailSubjectData.onError(error)
            }
        }.resume()
        return movieDetailSubjectData
    }
}
