//
//  ProductListViewModel.swift
//  AvriocAssignment
//
//  Created by Ashish Baghel on 22/05/2026.
//

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

    @ObservationIgnored
    private var cancellables = Set<AnyCancellable>()

    @ObservationIgnored
    private let searchSubject = PassthroughSubject<String, Never>()

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

    var state: ViewState<[Product]> = .idle

    private let service: ProductServiceProtocol

    init(service: ProductServiceProtocol = ProductService()) {
        self.service = service
        setupSearchDebounce()
    }

    private func setupSearchDebounce() {
        searchSubject
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] _ in
                self?.applyFilters()
            }
            .store(in: &cancellables)
    }

    func fetchProducts() {
        state = .loading

        service.fetchProducts()
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.state = .failure(error)
                }
            } receiveValue: { [weak self] products in
                guard let self else { return }
                self.products = products
                self.applyFilters()
            }
            .store(in: &cancellables)
    }

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

        state = filtered.isEmpty ? .empty : .success(filtered)
    }

    var categories: [String] {
        let categories = Set(products.map { $0.category })
        return ["All"] + categories.sorted()
    }
}
