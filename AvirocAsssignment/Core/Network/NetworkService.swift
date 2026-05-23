//
//  NetworkService.swift
//  AvirocAssignment
//
//  Created by Ashish Baghel on 23/05/2026.
//

import Combine
import Foundation

final class NetworkService: NetworkServiceProtocol {
    func request<T: Decodable>(_ type: T.Type, request: URLRequest) -> AnyPublisher<T, APIError> {
        URLSession.shared.dataTaskPublisher(for: request)
            .mapError { APIError.network($0) }
            .tryMap { output in
                guard let httpResponse = output.response as? HTTPURLResponse,
                      200...299 ~= httpResponse.statusCode else {
                    throw APIError.invalidResponse
                }
                return output.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { $0 as? APIError ?? .decodingError }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
