//
//  Company.swift
//  PruebaIngresoCeiba
//
//  Created by Brayam Alberto Mora Arias on 28/06/20.
//  Copyright © 2020 Brayam Alberto Mora Arias. All rights reserved.
//

import Foundation

struct Company: Codable {
    let name: String
    let catchPhrase: String
    let bs: String
    
    private enum CodingKeys: CodingKey {
        case name
        case catchPhrase
        case bs
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.catchPhrase = try container.decode(String.self, forKey: .catchPhrase)
        self.bs = try container.decode(String.self, forKey: .bs)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(catchPhrase, forKey: .catchPhrase)
        try container.encode(bs, forKey: .bs)
        
    }
}
