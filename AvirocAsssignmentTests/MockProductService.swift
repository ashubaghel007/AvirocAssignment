import Combine
import Foundation

@testable import AvirocAsssignment

// MARK: - Mock Service



final class MockProductService: ProductServiceProtocol {

    var result: Result<[Product], APIError> = .success([])
    var fetchCallCount = 0

    func fetchProducts(page: Int,
                       limit: Int) -> AnyPublisher<[Product], APIError> {

        fetchCallCount += 1

        return result.publisher
            .eraseToAnyPublisher()
    }
}

// MARK: - Mock Data

 extension Product {
    static let mock1 = Product(
        id: 1,
        title: "iPhone 15",
        description: "Apple Phone",
        category: "Electronics",
        price: 999,
        discountPercentage: 10,
        rating: 4.9,
        stock: 10,
        tags: [],
        brand: "Apple",
        sku: "IPHONE15",
        weight: 1,
        dimensions: Dimensions(width: 1, height: 1, depth: 1),
        warrantyInformation: "1 Year",
        shippingInformation: "Free Shipping",
        availabilityStatus: "In Stock",
        reviews: [],
        returnPolicy: "7 Days",
        minimumOrderQuantity: 1,
        meta: nil,
        images: [],
        thumbnail: ""
    )

    static let mock2 = Product(
        id: 2,
        title: "Face Wash",
        description: "Beauty Product",
        category: "Beauty",
        price: 99,
        discountPercentage: 5,
        rating: 4.2,
        stock: 20,
        tags: [],
        brand: "Nivea",
        sku: "FACEWASH",
        weight: 1,
        dimensions: Dimensions(width: 1, height: 1, depth: 1),
        warrantyInformation: "No Warranty",
        shippingInformation: "Free Shipping",
        availabilityStatus: "In Stock",
        reviews: [],
        returnPolicy: "No Return",
        minimumOrderQuantity: 1,
        meta: nil,
        images: [],
        thumbnail: ""
    )

    static let mockProducts = [mock1, mock2]
}
