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
        return networkService.request([Product].self, url: APIEndpoint.products)
    }
}
