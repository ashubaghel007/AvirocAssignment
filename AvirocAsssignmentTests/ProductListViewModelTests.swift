
import XCTest
import Combine
@testable import AvirocAsssignment

final class ProductListViewModelTests: XCTestCase {

    private var cancellables = Set<AnyCancellable>()

    func testSearchFilter() {

        let viewModel = ProductListViewModel(
            service: MockProductService()
        )

        viewModel.products = [
            Product(
                id: 1,
                title: "iPhone",
                price: 100,
                description: "",
                category: "Electronics",
                image: "",
                rating: Rating(rate: 4.5, count: 10)
            )
        ]

        viewModel.searchText = "iphone"
        viewModel.applyFilters()

     
    }
}
