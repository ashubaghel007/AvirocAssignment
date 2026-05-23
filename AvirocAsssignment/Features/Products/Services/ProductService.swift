//
//  ProductService.swift
//  AvirocAssignment
//
//  Created by Ashish Baghel on 22/05/2026.
//

import Combine

protocol ProductServiceProtocol {
    func fetchProducts(page: Int,
                       limit: Int) -> AnyPublisher<[Product], APIError>
}

final class ProductService: ProductServiceProtocol {

    private let networkService: NetworkServiceProtocol

    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }

    func fetchProducts(page: Int,
                       limit: Int) -> AnyPublisher<[Product], APIError> {

        do {
            let request = try APIEndpoint.products(page: page,
                                                   limit: limit)

            return networkService
                .request(ProductResponse.self, request: request)
                .map { $0.products }
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: APIError.invalidURL)
                .eraseToAnyPublisher()
        }
    }
}
