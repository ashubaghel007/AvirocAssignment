//
//  ProductListView.swift
//  AvirocAssignment
//
//  Created by Ashish Baghel on 22/05/2026.
//

import SwiftUI

struct ProductListView: View {

    @State private var viewModel = ProductListViewModel()

    var body: some View {
        NavigationStack {
            content
                .navigationTitle("Products")
                .searchable(
                    text: $viewModel.searchText,
                    prompt: "Search Products"
                )
                .task {
                    viewModel.fetchProducts()
                }
        }
    }

    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .loading:
            ProgressView("Loading...")
        case .idle, .empty:
            ContentUnavailableView(
                "No Products Found",
                systemImage: "magnifyingglass"
            )
        case .failure(let error):
            ContentUnavailableView(
                error.localizedDescription,
                systemImage: "exclamationmark.triangle"
            )
        case .success(let products):
            VStack {
                // menu
                menuContent
                    .padding(.horizontal)

                // List View to display items
                List(products) { product in
                    NavigationLink {
                        ProductDetailView(product: product)
                    } label: {
                        ProductCellView(product: product)
                            .onAppear {
                                viewModel.loadMoreProductsIfNeeded(
                                    currentItem: product
                                )
                            }
                    }
                    .buttonStyle(.plain)
                    .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
            }
        }
    }

    @ViewBuilder
    private var menuContent: some View {
        HStack {
            Menu {
                ForEach(
                    viewModel.categories,
                    id: \.self
                ) { category in
                    Button(category) {
                        viewModel.selectedCategory = category
                    }
                }
            } label: {
                Label(
                    viewModel.selectedCategory,
                    systemImage: "line.3.horizontal.decrease.circle"
                )
            }

            Spacer()

            Picker(
                "Sort",
                selection: $viewModel.sortOption
            ) {
                ForEach(
                    SortOption.allCases,
                    id: \.self
                ) { option in
                    Text(option.rawValue)
                        .tag(option)
                }
            }
            .pickerStyle(.menu)
        }
    }
}
