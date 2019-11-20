//
//  DetailViewModel.swift
//  OtusRxProject
//
//  Created by Murzin Mikhail on 20.11.2019.
//  Copyright © 2019 Murzin Mikhail. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class DetailViewModel {
    
    private let movieService: TheMovieDbService
    private let movieId: Int
    private let movieSubjectData : PublishSubject<DetailMovie> = PublishSubject()
    private let disposeBag = DisposeBag()
    
    init(id: Int, networkService: TheMovieDbService?) {
        if let service = networkService {
            self.movieService = service
        } else {
            fatalError("DetailViewModel: TheMovieDbService can't be nil")
        }
        if(id >= 0){
            self.movieId = id
        } else {
            fatalError("DetailViewModel: movieId can't be less 0")
        }
    }
    
    func loadMovieData() -> PublishSubject<DetailMovie>{
        movieService.getMovieDetail(self.movieId)
            .subscribe(
                onNext: { data  in
                if let movieData = data {
                    self.movieSubjectData.onNext(movieData)
                }
            },
                onError: { error in
                
            })
            .disposed(by: disposeBag)
        return self.movieSubjectData
    }
    
}
