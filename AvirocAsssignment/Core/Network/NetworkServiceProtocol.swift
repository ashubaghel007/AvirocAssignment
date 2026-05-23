//
//  NetworkServiceProtocol.swift
//  AvirocAssignment
//
//  Created by Ashish Baghel on 23/05/2026.
//

import Combine
import Foundation

protocol NetworkServiceProtocol {
    func request<T: Decodable>(_ type: T.Type,
                               request: URLRequest) -> AnyPublisher<T, APIError>
}
