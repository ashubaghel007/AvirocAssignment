//
//  ProductService.swift
//  AvirocAssignment
//
//  Created by Ashish Baghel on 22/05/2026.
//

import Combine

protocol ProductServiceProtocol {
    func fetchProducts() -> AnyPublisher<[Product], APIError>
}

final class ProductService: ProductServiceProtocol {

    private let networkService: NetworkServiceProtocol

    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }

    func fetchProducts() -> AnyPublisher<[Product], APIError> {
        do {
            let request = try APIEndpoint.products
            return networkService.request([Product].self, request: request)
        } catch {
            return Fail(error: APIError.invalidURL)
                .eraseToAnyPublisher()
        }
    }
}
