//
//  APIEndpoint.swift
//  AvirocAssignment
//
//  Created by Ashish Baghel on 23/05/2026.
//

import Foundation

//enum APIEndpoint {
//    static let products = "https://fakestoreapi.com/products"
//}

enum APIEndpoint {
    static let baseURL = "https://fakestoreapi.com"

    static var products: URLRequest {
        get throws {
            try URLRequest.make(url: baseURL + "/products")
        }
    }

    static func products(page: Int, limit: Int = 5) throws -> URLRequest {
        try URLRequest.make(
            url: baseURL + "/products",
            queryParameters: [
                "page": "\(page)",
                "limit": "\(limit)"
            ]
        )
    }
}
