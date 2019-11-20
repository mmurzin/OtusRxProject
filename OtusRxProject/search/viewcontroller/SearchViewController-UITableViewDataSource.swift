//
//  SearchViewController-UITableViewDataSource.swift
//  OtusRxProject
//
//  Created by Murzin Mikhail on 20.11.2019.
//  Copyright © 2019 Murzin Mikhail. All rights reserved.
//

import UIKit
import Foundation

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
