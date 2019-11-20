//
//  Movie.swift
//  OtusRxProject
//
//  Created by Murzin Mikhail on 05.11.2019.
//  Copyright © 2019 Murzin Mikhail. All rights reserved.
//

import Foundation

struct Movie: Decodable {
    let title: String
    let vote: Double
    let id: Int
    enum Keys: String, CodingKey {
        case title
        case vote = "vote_average"
        case id
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        title = try container.decode(String.self, forKey: .title)
        vote = try container.decode(Double.self, forKey: .vote)
        id = try container.decode(Int.self, forKey: .id)
    }
}
