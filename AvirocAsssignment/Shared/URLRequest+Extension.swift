//
//  URLRequest+Extension.swift
//  AvirocAsssignment
//
//  Created by Ashish Baghel on 24/05/2026.
//
import Foundation

extension URLRequest {
    static func make(url: String,
                     method: HTTPMethod = .get,
                     queryParameters: [String: String]? = nil,
                     headers: [String: String]? = nil) throws -> URLRequest {

        guard var components = URLComponents(string: url) else {
            throw APIError.invalidURL
        }

        if let queryParameters {
            components.queryItems = queryParameters.map {
                URLQueryItem(name: $0.key, value: $0.value)
            }
        }

        guard let url = components.url else {
            throw APIError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        headers?.forEach {
            request.setValue($0.value, forHTTPHeaderField: $0.key)
        }

        return request
    }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}
