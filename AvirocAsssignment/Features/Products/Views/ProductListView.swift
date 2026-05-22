//
//  ProductListView.swift
//  AvirocAssignment
//
//  Created by Ashish Baghel on 22/05/2026.
//

import SwiftUI

struct ProductListView: View {

    @State private var viewModel = ProductListViewModel()

    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]

    var body: some View {
        NavigationStack {
            content
                .navigationTitle("Products")
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
        case .empty, .idle:
            Text("No Products Found")
        case .failure(let error):
            Text(error.localizedDescription)
        case .success(let products):
            VStack {
                TextField("Search Products", text: $viewModel.searchText)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)

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
                        Text(viewModel.selectedCategory)
                    }

                    Spacer()

                    Picker(
                        "Sort",
                        selection: $viewModel.sortOption
                    ) {

                        ForEach(
                            SortOption.allCases,
                            id: \.self
                        ) {
                            Text($0.rawValue)
                        }
                    }
                    .pickerStyle(.menu)
                }
                .padding(.horizontal)

                ScrollView {
                    LazyVGrid(
                        columns: columns,
                        spacing: 16
                    ) {
                        ForEach(products) { product in
                            NavigationLink {
                                ProductDetailView(product: product)
                            } label: {
                                ProductCellView(product: product)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding()
                }
            }
        }
    }
}
