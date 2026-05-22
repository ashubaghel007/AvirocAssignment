//
//  ProductCellView.swift
//  AvirocAssignment
//
//  Created by Ashish Baghel on 22/05/2026.
//

import SwiftUI

struct ProductCellView: View {

    let product: Product

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            AsyncImage(url: URL(string: product.image)) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .frame(height: 120)

            Text(product.title)
                .font(.headline)
                .lineLimit(2)

            Text("$\(product.price, specifier: "%.2f")")

            Text("⭐️ \(product.rating.rate, specifier: "%.1f")")
                .font(.caption)
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)
    }
}
