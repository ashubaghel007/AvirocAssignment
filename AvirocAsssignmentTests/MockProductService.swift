
import Combine
@testable import AvirocAsssignment

final class MockProductService: ProductServiceProtocol {

    var result: Result<[Product], APIError> = .success([])

    func fetchProducts() -> AnyPublisher<[Product], APIError> {
        result.publisher
            .eraseToAnyPublisher()
    }
}
