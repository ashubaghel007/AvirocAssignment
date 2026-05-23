//
//  ProductDetailView.swift
//  AvirocAssignment
//
//  Created by Ashish Baghel on 23/05/2026.
//

import SwiftUI

struct ProductDetailView: View {
    let product: Product

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Spacer()
                    AsyncImage(url: URL(string: product.thumbnail)) { image in
                        image
                            .resizable()
                            .scaledToFit()

                    } placeholder: {
                        ProgressView()
                    }
                    .frame(height: 250)
                    Spacer()
                }

                Text(product.title)
                    .font(.title2)
                    .bold()

                Text(product.category.capitalized)
                    .foregroundColor(.secondary)

                Text("$\(product.price, specifier: "%.2f")")
                    .font(.title3)
                    .bold()

                Text(product.description)
                Text("Rating: \(product.rating, specifier: "%.1f")")
                Text("Stock: \(product.stock)")
            }
            .padding()
        }
        .navigationTitle("Details")
    }
}
