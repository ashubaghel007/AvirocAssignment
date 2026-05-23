//
//  APIError.swift
//  AvirocAssignment
//
//  Created by Ashish Baghel on 23/05/2026.
//


import Foundation

enum APIError: Error, LocalizedError {
    case invalidURL
    case invalidResponse
    case decodingError
    case network(Error)
    case unknown

    var errorDescription: String? {
        switch self {
        case .invalidURL: return "Invalid URL"
        case .invalidResponse: return "Invalid Response"
        case .decodingError: return "Decoding Failed"
        case .network(let error): return error.localizedDescription
        case .unknown: return "Unknown Error"
        }
    }
}
