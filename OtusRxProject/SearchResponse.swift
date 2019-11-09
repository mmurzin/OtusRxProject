//
//  SearchResponse.swift
//  OtusRxProject
//
//  Created by Murzin Mikhail on 05.11.2019.
//  Copyright © 2019 Murzin Mikhail. All rights reserved.
//

import Foundation

struct SearchResponse: Decodable {
    let results: [Movie]

    enum Keys: String, CodingKey {
        case results
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        results = try container.decode([Movie].self, forKey: .results)
    }
}
