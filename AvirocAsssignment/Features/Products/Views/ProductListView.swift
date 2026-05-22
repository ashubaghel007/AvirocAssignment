import SwiftUI

struct ProductListView: View {

    @State private var viewModel = ProductListViewModel()

    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

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
