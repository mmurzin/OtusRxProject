//
//  SearchViewModel.swift
//  OtusRxProject
//
//  Created by Murzin Mikhail on 20.11.2019.
//  Copyright © 2019 Murzin Mikhail. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa


class SearchViewModel {
    
    private let movieService: TheMovieDbService
    private let moviesSubjectData : PublishSubject<[Movie]> = PublishSubject()
    private var searchDisposable: Disposable? = nil
    
    init(networkService: TheMovieDbService?) {
        if let service = networkService {
            self.movieService = service
        } else {
            fatalError("SearchViewModel: TheMovieDbService can't be nil")
        }
    }
    
    func searchMovies(_ query: String) -> PublishSubject<[Movie]>{
        searchDisposable?.dispose()
        self.searchDisposable = movieService.searchMovies(query)
        .subscribe(
            onNext: { items  in
                if let movieItems = items {
                    self.moviesSubjectData.onNext(movieItems)
                }
                
        },
            onError: { error in
            
        })
        return moviesSubjectData
    }
}
