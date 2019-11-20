//
//  SearchViewController.swift
//  OtusRxProject
//
//  Created by Murzin Mikhail on 04.11.2019.
//  Copyright © 2019 Murzin Mikhail. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SearchViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    let disposeBag = DisposeBag()
    
    let service = TheMovieDbService()
    private let minSearchSize = 3
    
    var movies: [Movie] = [] {
        didSet {
            DispatchQueue.main.async { [unowned self] in
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.placeholder = "Eng: Movie name"
        
        searchBar.rx.value
            .filter { q in
                if let query = q {
                    return query.count >= self.minSearchSize
                } else {
                    return false
                }
             }
            .subscribe(onNext: { q in
                if let query = q {
                    self.movies = []
                    self.service.searchMovies(query){ items, error in
                        if let movies = items {
                            self.movies = movies
                        } else {
                            print(error)
                        }
                    }
                }
        })
        .disposed(by: disposeBag)
        
        searchBar.rx.searchButtonClicked
        .subscribe(onNext: { _ in
            if((self.searchBar.text?.count ?? 0) < self.minSearchSize){
                let uialert = UIAlertController(title: "Query error", message: "Search word size must be greater than 2 symbols", preferredStyle: UIAlertController.Style.alert)
                   uialert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))
                self.present(uialert, animated: true, completion: nil)
            }
        })
        .disposed(by: disposeBag)
        
        tableView.rx.itemSelected
        .subscribe(onNext:  { indexPath in
            let movie = self.movies[indexPath.row]
            print("Tapped id = \(movie.id)")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewController(identifier: "DetailViewController")
            if viewController is DetailViewController {
                (viewController as! DetailViewController).movieId = movie.id
            }
            self.navigationController?.pushViewController(viewController, animated: true)
        })
        .disposed(by: disposeBag)
    }
    
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: .movieCellIdentifier, for: indexPath)

        let movie = movies[indexPath.row]
        cell.textLabel?.text = movie.title
        cell.detailTextLabel?.text = String(movie.vote)
        return cell
    }

}


private extension String {
    static let movieCellIdentifier = "MovieCell"
}
