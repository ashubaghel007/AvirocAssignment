//
//  ProductListViewModel.swift
//  AvriocAssignment
//
//  Created by Ashish Baghel on 22/05/2026.

import Combine
import Foundation
import Observation

enum SortOption: String, CaseIterable {
    case priceLowToHigh = "Price ↑"
    case priceHighToLow = "Price ↓"
    case rating = "Rating"
}

@Observable
final class ProductListViewModel {

    @ObservationIgnored
    var products: [Product] = []

    var state: ViewState<[Product]> = .idle

    var searchText = "" {
        didSet {
            searchSubject.send(searchText)
        }
    }

    var selectedCategory = "All" {
        didSet {
            applyFilters()
        }
    }

    var sortOption: SortOption = .priceLowToHigh {
        didSet {
            applyFilters()
        }
    }

    // MARK: - Pagination
    private(set) var currentPage = 1
    private let limit = 10

    private var isLoading = false
    private var hasMorePages = true

    // MARK: - Private Properties
    @ObservationIgnored
    private var cancellables = Set<AnyCancellable>()

    @ObservationIgnored
    private let searchSubject = PassthroughSubject<String, Never>()

    private let service: ProductServiceProtocol

    // MARK: - Init
    init(service: ProductServiceProtocol = ProductService()) {
        self.service = service
        setupSearchDebounce()
    }

    // MARK: - Search
    private func setupSearchDebounce() {
        searchSubject
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] _ in
                self?.applyFilters()
            }
            .store(in: &cancellables)
    }

    // MARK: - Fetch Products
    func fetchProducts() {

        guard !isLoading, hasMorePages else { return }

        isLoading = true

        if currentPage == 1 {
            state = .loading
        }

        service.fetchProducts(
            page: currentPage,
            limit: limit
        )
        .receive(on: RunLoop.main)
        .sink { [weak self] completion in

            guard let self else { return }

            self.isLoading = false

            if case .failure(let error) = completion {
                self.state = .failure(error)
            }

        } receiveValue: { [weak self] newProducts in

            guard let self else { return }

            // Detect last page
            if newProducts.count < self.limit {
                self.hasMorePages = false
            }

            self.products.append(contentsOf: newProducts)

            self.currentPage += 1

            self.applyFilters()
        }
        .store(in: &cancellables)
    }

    // MARK: - Load More Trigger

    func loadMoreProductsIfNeeded(currentItem product: Product) {

        guard let lastProduct = products.last else {
            return
        }

        if product.id == lastProduct.id {
            fetchProducts()
        }
    }

    // MARK: - Filters

    func applyFilters() {

        var filtered = products

        // Search
        if !searchText.isEmpty {
            filtered = filtered.filter {
                $0.title.localizedCaseInsensitiveContains(searchText)
            }
        }

        // Category
        if selectedCategory != "All" {
            filtered = filtered.filter {
                $0.category == selectedCategory
            }
        }

        // Sorting
        switch sortOption {

        case .priceLowToHigh:
            filtered.sort { $0.price < $1.price }

        case .priceHighToLow:
            filtered.sort { $0.price > $1.price }

        case .rating:
            filtered.sort { $0.rating > $1.rating }
        }

        state = filtered.isEmpty
            ? .empty
            : .success(filtered)
    }

    // MARK: - Categories

    var categories: [String] {

        let categories = Set(
            products.map { $0.category }
        )

        return ["All"] + categories.sorted()
    }
}
