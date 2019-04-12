//
//  Product.swift
//  interview-kiwari-ios
//
//  Created by Cahyanto Setya Budi on 4/12/19.
//  Copyright © 2019 Cahyanto Setya Budi. All rights reserved.
//

import Foundation

struct Product: Codable {
    let id: Int
    let name: String
    let price: Int
    let imagePath: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case price
        case imagePath = "image"
    }
}

extension Product {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(name, forKey: .name)
        try container.encode(price, forKey: .price)
        try container.encode(imagePath, forKey: .imagePath)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        price = try container.decodeIfPresent(Int.self, forKey: .price) ?? 0
        imagePath = try container.decodeIfPresent(String.self, forKey: .imagePath) ?? ""
    }
}
