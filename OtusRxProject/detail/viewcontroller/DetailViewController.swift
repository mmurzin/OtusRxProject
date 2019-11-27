//
//  DetailViewController.swift
//  OtusRxProject
//
//  Created by Murzin Mikhail on 09.11.2019.
//  Copyright © 2019 Murzin Mikhail. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class DetailViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var tagLineLabel: UILabel!
    
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var movieId = -1
    private lazy var viewModel = DetailViewModel(id: movieId, networkService: ServiceLocator.shared.getService())
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.loadMovieData()
            .subscribe(onNext: { info  in
                self.updateMovieData(info)
            })
            .disposed(by: disposeBag)
    }
    
    private func updateMovieData(_ movieInfo:DetailMovie) {
        DispatchQueue.main.async {
            self.activityIndicator.isHidden = true
            self.titleLabel.text = movieInfo.title
            self.tagLineLabel.text = movieInfo.tagLine
            self.descriptionTextView.text = movieInfo.overview
        }
    }

}
