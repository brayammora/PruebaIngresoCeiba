//
//  Publication.swift
//  PruebaIngresoCeiba
//
//  Created by Brayam Alberto Mora Arias on 28/06/20.
//  Copyright © 2020 Brayam Alberto Mora Arias. All rights reserved.
//

import Foundation

struct Publication: Decodable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
    
    private enum CodingKeys: CodingKey {
        case userId
        case id
        case title
        case body
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userId = try container.decode(Int.self, forKey: .userId)
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.body = try container.decode(String.self, forKey: .body)
    }
}
