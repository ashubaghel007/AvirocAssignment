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
            title: "T-Shirt",
            description: "Cotton Shirt",
            category: "mens-shirts",
            price: 100,
            discountPercentage: 5,
            rating: 4.0,
            stock: 20,
            tags: [],
            brand: "Nike",
            sku: "TSHIRT-001",
            weight: 1,
            dimensions: Dimensions(
                width: 5,
                height: 10,
                depth: 1
            ),
            warrantyInformation: "No Warranty",
            shippingInformation: "Standard Shipping",
            availabilityStatus: "In Stock",
            reviews: [],
            returnPolicy: "3 Days",
            minimumOrderQuantity: 1,
            meta: nil,
            images: [],
            thumbnail: ""
        ),
        Product(
            id: 2,
            title: "iPhone",
            description: "Apple Phone",
            category: "smartphones",
            price: 1000,
            discountPercentage: 10,
            rating: 4.8,
            stock: 10,
            tags: [],
            brand: "Apple",
            sku: "IPHONE-001",
            weight: 1,
            dimensions: Dimensions(
                width: 10,
                height: 20,
                depth: 1
            ),
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
    ]
}
