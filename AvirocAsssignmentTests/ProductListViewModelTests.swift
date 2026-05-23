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

    // MARK: - Life Cycle

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

    func test_fetchProducts_success_updatesStateWithProducts() {

        // Given
        mockService.result = .success(MockData.products)

        // When
        sut.fetchProducts()

        // Then
        guard case .success(let products) = sut.state else {
            XCTFail("Expected success state")
            return
        }

        XCTAssertEqual(products.count, 2)
        XCTAssertEqual(products.first?.title, "T-Shirt")
    }

    func test_fetchProducts_failure_updatesStateWithError() {

        // Given
        mockService.result = .failure(.invalidResponse)

        // When
        sut.fetchProducts()

        // Then
        guard case .failure(let error) = sut.state else {
            XCTFail("Expected failure state")
            return
        }

        XCTAssertEqual(
            error.localizedDescription,
            APIError.invalidResponse.localizedDescription
        )
    }

    // MARK: - Search

    func test_applyFilters_withSearchText_filtersProducts() {

        // Given
        sut.products = MockData.products
        sut.searchText = "iPhone"

        // When
        sut.applyFilters()

        // Then
        guard case .success(let products) = sut.state else {
            XCTFail("Expected success state")
            return
        }

        XCTAssertEqual(products.count, 1)
        XCTAssertEqual(products.first?.title, "iPhone")
    }

    // MARK: - Category

    func test_applyFilters_withSelectedCategory_filtersProducts() {

        // Given
        sut.products = MockData.products
        sut.selectedCategory = "smartphones"

        // When
        sut.applyFilters()

        // Then
        guard case .success(let products) = sut.state else {
            XCTFail("Expected success state")
            return
        }

        XCTAssertEqual(products.count, 1)
        XCTAssertEqual(products.first?.category, "smartphones")
    }

    // MARK: - Sorting

    func test_applyFilters_sortByPriceLowToHigh_sortsCorrectly() {

        // Given
        sut.products = MockData.products
        sut.sortOption = .priceLowToHigh

        // When
        sut.applyFilters()

        // Then
        guard case .success(let products) = sut.state else {
            XCTFail("Expected success state")
            return
        }

        XCTAssertEqual(products.first?.price, 100)
    }

    func test_applyFilters_sortByPriceHighToLow_sortsCorrectly() {

        // Given
        sut.products = MockData.products
        sut.sortOption = .priceHighToLow

        // When
        sut.applyFilters()

        // Then
        guard case .success(let products) = sut.state else {
            XCTFail("Expected success state")
            return
        }

        XCTAssertEqual(products.first?.price, 1000)
    }

    func test_applyFilters_sortByRating_sortsCorrectly() {

        // Given
        sut.products = MockData.products
        sut.sortOption = .rating

        // When
        sut.applyFilters()

        // Then
        guard case .success(let products) = sut.state else {
            XCTFail("Expected success state")
            return
        }

        XCTAssertEqual(products.first?.rating, 4.8)
    }

    // MARK: - Empty State
    func test_applyFilters_withNoMatchingProducts_returnsEmptyState() {

        // Given
        sut.products = MockData.products
        sut.searchText = "MacBook"

        // When
        sut.applyFilters()

        // Then
        guard case .empty = sut.state else {
            XCTFail("Expected empty state")
            return
        }
    }

    // MARK: - Categories

    func test_categories_returnsAllCategories() {

        // Given
        sut.products = MockData.products

        // When
        let categories = sut.categories

        // Then
        XCTAssertEqual(
            categories,
            ["All", "mens-shirts", "smartphones"]
        )
    }
}
