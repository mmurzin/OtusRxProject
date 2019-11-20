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
    private let movieListSubjectData : PublishSubject<[Movie]?> = PublishSubject()
    
    func searchMovies(_ q: String) -> PublishSubject<[Movie]?>{
        let url = TheMovieDbEndpoint.search(q).url
        print(url)
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let responseError = error{
                self.movieListSubjectData.onError(responseError)
                return
            }
            guard let data = data else {
                return
            }
            print(data)
            do {
                let searchResult = try JSONDecoder().decode(SearchResponse.self, from: data)
                self.movieListSubjectData.onNext(searchResult.results)
            } catch {
                self.movieListSubjectData.onError(error)
            }
        }.resume()
        return movieListSubjectData
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
