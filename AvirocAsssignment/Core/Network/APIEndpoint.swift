//
//  APIEndpoint.swift
//  AvirocAssignment
//
//  Created by Ashish Baghel on 23/05/2026.
//

import Foundation

//
//  APIEndpoint.swift
//  AvirocAssignment
//
//  Created by Ashish Baghel on 23/05/2026.
//

import Foundation

enum APIEndpoint {

    static let baseURL = "https://dummyjson.com"

    static var products: URLRequest {
        get throws {
            try URLRequest.make(
                url: baseURL + "/products"
            )
        }
    }

    static func products(page: Int,
                         limit: Int = 10) throws -> URLRequest {

        let skip = (page - 1) * limit

        return try URLRequest.make(
            url: baseURL + "/products",
            queryParameters: [
                "limit": "\(limit)",
                "skip": "\(skip)"
            ]
        )
    }
}
