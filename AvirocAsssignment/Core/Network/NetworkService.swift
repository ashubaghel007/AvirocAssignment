//
//  NetworkService.swift
//  AvirocAssignment
//
//  Created by Ashish Baghel on 23/05/2026.
//

import Combine
import Foundation

final class NetworkService: NetworkServiceProtocol {

    func request<T: Decodable>(
        _ type: T.Type,
        url: String
    ) -> AnyPublisher<T, APIError> {

        guard let url = URL(string: url) else {
            return Fail(error: APIError.invalidURL)
                .eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .mapError { APIError.network($0) }
            .tryMap { output in
                guard let response = output.response as? HTTPURLResponse,
                    200...299 ~= response.statusCode
                else {
                    throw APIError.invalidResponse
                }
                return output.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError {
                if let error = $0 as? APIError {
                    return error
                }
                return APIError.decodingError
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
