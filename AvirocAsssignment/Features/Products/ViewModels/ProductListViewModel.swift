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

    var searchText = "" {
        didSet {
            applyFilters()
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
    }

    func fetchProducts() {
        state = .loading
        service.fetchProducts()
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.state = .failure(error)
                }
            } receiveValue: { [weak self] products in
                guard let weakSelf = self else { return }
                weakSelf.products = products
                weakSelf.applyFilters()
            }.store(in: &cancellables)
    }

    func applyFilters() {
        var filtered = products
        if !searchText.isEmpty {
            filtered = filtered.filter {
                $0.title.localizedCaseInsensitiveContains(searchText)
            }
        }

        if selectedCategory != "All" {
            filtered = filtered.filter {
                $0.category == selectedCategory
            }
        }

        switch sortOption {
        case .priceLowToHigh:
            filtered.sort { $0.price < $1.price }

        case .priceHighToLow:
            filtered.sort { $0.price > $1.price }

        case .rating:
            filtered.sort { $0.rating.rate > $1.rating.rate }
        }

        self.state =
            products.isEmpty
            ? .empty
            : .success(filtered)
    }

    var categories: [String] {
        let categories = Set(
            products.map { $0.category }
        )

        return ["All"] + categories.sorted()
    }
}
