//
//  DetailViewController.swift
//  OtusRxProject
//
//  Created by Murzin Mikhail on 09.11.2019.
//  Copyright © 2019 Murzin Mikhail. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var tagLineLabel: UILabel!
    
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var movieId = -1
    let service = TheMovieDbService()
    override func viewDidLoad() {
        super.viewDidLoad()
        if movieId >= 0 {
            service.getMovieDetail(movieId){ info, error in
                if let movieInfo = info {
                    DispatchQueue.main.async {
                        self.titleLabel.text = movieInfo.title
                        self.tagLineLabel.text = movieInfo.tagLine
                        self.descriptionTextView.text = movieInfo.overview
                    }
                } else {
                    print(error)
                }
            }
        }
    }

}
