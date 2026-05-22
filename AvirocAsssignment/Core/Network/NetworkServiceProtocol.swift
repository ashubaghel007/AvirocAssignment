//
//  NetworkServiceProtocol.swift
//  AvirocAssignment
//
//  Created by Ashish Baghel on 23/05/2026.
//

import Combine

protocol NetworkServiceProtocol {
    func request<T: Decodable>(
        _ type: T.Type,
        url: String
    ) -> AnyPublisher<T, APIError>
}
