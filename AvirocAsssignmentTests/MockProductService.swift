//
//  MockProductService.swift
//  AvirocAsssignmentTests
//

import Combine
import Foundation

@testable import AvirocAsssignment

final class MockProductService: ProductServiceProtocol {

    var result: Result<[Product], APIError> = .success([])

    func fetchProducts() -> AnyPublisher<[Product], APIError> {
        result.publisher
            .eraseToAnyPublisher()
    }
}

enum MockData {
    static let products: [Product] = [
        Product(
            id: 1,
            title: "iPhone",
            price: 1000,
            description: "Apple Phone",
            category: "Electronics",
            image: "",
            rating: Rating(
                rate: 4.8,
                count: 100
            )
        ),
        Product(
            id: 2,
            title: "T-Shirt",
            price: 100,
            description: "Cotton Shirt",
            category: "Fashion",
            image: "",
            rating: Rating(
                rate: 4.0,
                count: 50
            )
        ),
    ]
}
