//
//  ProductListViewModelTests.swift
//  AvirocAssignmentTests
//
//  Created by Ashish Baghel on 23/05/2026.
//

import XCTest
import Combine
@testable import AvirocAsssignment

final class ProductListViewModelTests: XCTestCase {

    // MARK: - Properties

    private var sut: ProductListViewModel!
    private var mockService: MockProductService!
    private var cancellables: Set<AnyCancellable>!

    // MARK: - Lifecycle

    override func setUp() {
        super.setUp()
        mockService = MockProductService()
        sut = ProductListViewModel(service: mockService)
        cancellables = []
    }

    override func tearDown() {
        sut = nil
        mockService = nil
        cancellables = nil
        super.tearDown()
    }

    // MARK: - Fetch Products

    func test_fetchProducts_success_updatesStateAndProducts() {

        // Given
        let products = Product.mockProducts
        mockService.result = .success(products)

        let expectation = XCTestExpectation(description: "Fetch products success")

        // When
        sut.fetchProducts()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {

            // Then
            guard case .success(let stateProducts) = self.sut.state else {
                XCTFail("Expected success state")
                return
            }

            XCTAssertEqual(stateProducts.count, 2)
            XCTAssertEqual(self.sut.products.count, 2)
            XCTAssertEqual(self.sut.currentPage, 2)

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }

    func test_fetchProducts_failure_updatesFailureState() {

        // Given
        mockService.result = .failure(.invalidResponse)

        let expectation = XCTestExpectation(description: "Fetch products failure")

        // When
        sut.fetchProducts()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {

            // Then
            guard case .failure(let error) = self.sut.state else {
                XCTFail("Expected failure state")
                return
            }

            XCTAssertEqual(error, .invalidResponse)

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }

    func test_fetchProducts_lastPage_setsHasMorePagesFalse() {

        // Given
        mockService.result = .success([Product.mock1])

        let expectation = XCTestExpectation(description: "Last page handled")

        // When
        sut.fetchProducts()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {

            // Try loading again
            self.sut.fetchProducts()

            // Then
            XCTAssertEqual(self.mockService.fetchCallCount, 1)

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }

    // MARK: - Search

    func test_searchText_filtersProducts() {

        // Given
        loadProducts()

        let expectation = XCTestExpectation(description: "Search filter applied")

        // When
        sut.searchText = "iPhone"

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {

            // Then
            guard case .success(let filteredProducts) = self.sut.state else {
                XCTFail("Expected success state")
                return
            }

            XCTAssertEqual(filteredProducts.count, 1)
            XCTAssertEqual(filteredProducts.first?.title, "iPhone 15")

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2.0)
    }

    // MARK: - Category Filter

    func test_selectedCategory_filtersProducts() {

        // Given
        loadProducts()

        // When
        sut.selectedCategory = "Beauty"

        // Then
        guard case .success(let filteredProducts) = sut.state else {
            XCTFail("Expected success state")
            return
        }

        XCTAssertEqual(filteredProducts.count, 1)
        XCTAssertEqual(filteredProducts.first?.category, "Beauty")
    }

    // MARK: - Sorting

    func test_sortOption_priceLowToHigh_sortsCorrectly() {

        // Given
        loadProducts()

        // When
        sut.sortOption = .priceLowToHigh

        // Then
        guard case .success(let sortedProducts) = sut.state else {
            XCTFail("Expected success state")
            return
        }

        XCTAssertEqual(sortedProducts.first?.price, 99)
        XCTAssertEqual(sortedProducts.last?.price, 999)
    }

    func test_sortOption_priceHighToLow_sortsCorrectly() {

        // Given
        loadProducts()

        // When
        sut.sortOption = .priceHighToLow

        // Then
        guard case .success(let sortedProducts) = sut.state else {
            XCTFail("Expected success state")
            return
        }

        XCTAssertEqual(sortedProducts.first?.price, 999)
        XCTAssertEqual(sortedProducts.last?.price, 99)
    }

    func test_sortOption_rating_sortsCorrectly() {

        // Given
        loadProducts()

        // When
        sut.sortOption = .rating

        // Then
        guard case .success(let sortedProducts) = sut.state else {
            XCTFail("Expected success state")
            return
        }

        XCTAssertEqual(sortedProducts.first?.rating, 4.9)
        XCTAssertEqual(sortedProducts.last?.rating, 4.2)
    }


    func test_loadMoreProductsIfNeeded_doesNotCallFetchForNonLastItem() {

        // Given
        loadProducts()

        let firstProduct = Product.mock1

        // When
        sut.loadMoreProductsIfNeeded(currentItem: firstProduct)

        // Then
        XCTAssertEqual(mockService.fetchCallCount, 1)
    }

    // MARK: - Categories

    func test_categories_returnsUniqueSortedCategories() {

        // Given
        loadProducts()

        // When
        let categories = sut.categories

        // Then
        XCTAssertEqual(categories, ["All", "Beauty", "Electronics"])
    }
}

// MARK: - Helper
private extension ProductListViewModelTests {
    func loadProducts() {
        mockService.result = .success(Product.mockProducts)
        let expectation = XCTestExpectation(description: "Products loaded")
        sut.fetchProducts()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
}
