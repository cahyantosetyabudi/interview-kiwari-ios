//
//  BaseResponse.swift
//  interview-kiwari-ios
//
//  Created by Cahyanto Setya Budi on 4/12/19.
//  Copyright © 2019 Cahyanto Setya Budi. All rights reserved.
//

import Foundation

struct BaseResponse<T>: Decodable where T: Decodable {
    let statusCode: Int
    let message: String
    let data: T
}

extension BaseResponse {
    enum CodingKeys: String, CodingKey {
        case statusCode = "code"
        case message = "msg"
        case data
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        statusCode = try container.decodeIfPresent(Int.self, forKey: .statusCode) ?? 0
        message = try container.decodeIfPresent(String.self, forKey: .message) ?? ""
        data = try container.decode(T.self, forKey: .data)
    }
}
