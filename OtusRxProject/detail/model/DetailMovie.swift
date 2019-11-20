//
//  DetailMovie.swift
//  OtusRxProject
//
//  Created by Murzin Mikhail on 09.11.2019.
//  Copyright © 2019 Murzin Mikhail. All rights reserved.
//

import Foundation


struct DetailMovie: Decodable {
    let title: String
    let tagLine: String
    let overview: String
    
    enum Keys: String, CodingKey {
        case title
        case tagLine = "tagline"
        case overview
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        title = try container.decode(String.self, forKey: .title)
        tagLine = try container.decode(String.self, forKey: .tagLine)
        overview = try container.decode(String.self, forKey: .overview)
    }
}
