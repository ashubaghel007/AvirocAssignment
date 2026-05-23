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
        HStack(alignment: .top, spacing: 12) {
            AsyncImage(url: URL(string: product.image)) { image in
                image
                    .resizable()
                    .scaledToFit()

            } placeholder: {
                ProgressView()
            }
            .frame(width: 100, height: 100)

            VStack(alignment: .leading, spacing: 8) {
                Text(product.title)
                    .font(.headline)
                    .lineLimit(2)

                Text("$\(product.price, specifier: "%.2f")")
                    .font(.subheadline)

                Text("⭐️ \(product.rating.rate, specifier: "%.1f")")
                    .font(.caption)
            }

            Spacer()
        }
        .padding(.vertical, 8)
    }
}
