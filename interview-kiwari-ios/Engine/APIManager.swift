//
//  APIManager.swift
//  interview-kiwari-ios
//
//  Created by Cahyanto Setya Budi on 4/12/19.
//  Copyright © 2019 Cahyanto Setya Budi. All rights reserved.
//

import Foundation
import Moya
import RxSwift


let provider: MoyaProvider<APIManager> = MoyaProvider<APIManager>(plugins: [NetworkLoggerPlugin(verbose: true)])

enum APIManager {
    case getProducts
    case addProduct(Encodable)
    case updateProduct(Int, Encodable)
    case deleteProduct(Int)
}

extension APIManager: TargetType {
    var baseURL: URL {
        return URL(string: "https://belanja-api.herokuapp.com")!
    }
    
    var path: String {
        switch self {
        case .getProducts, .addProduct:
            return "/products"
        case .updateProduct(let id, _), .deleteProduct(let id):
            return "/products/\(id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getProducts:
            return .get
        case .addProduct:
            return .post
        case .updateProduct:
            return .put
        case .deleteProduct:
            return .delete
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getProducts:
            return .requestPlain
        case .addProduct(let body):
            return .requestJSONEncodable(body)
        case .updateProduct( _, let body):
            return .requestJSONEncodable(body)
        case .deleteProduct:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return [:]
    }
}
