//
//  Coordinates.swift
//  PruebaIngresoCeiba
//
//  Created by Brayam Alberto Mora Arias on 28/06/20.
//  Copyright © 2020 Brayam Alberto Mora Arias. All rights reserved.
//

import Foundation

struct Coordinates: Codable {
    let lat: String
    let lng: String
    
    private enum CodingKeys: CodingKey {
        case lat
        case lng
    }
    
    init(from decoder: Decoder) throws {
        let container  = try decoder.container(keyedBy: CodingKeys.self)
        self.lat = try container.decode(String.self, forKey: .lat)
        self.lng = try container.decode(String.self, forKey: .lng)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(lat, forKey: .lat)
        try container.encode(lng, forKey: .lng)
        
    }
}
