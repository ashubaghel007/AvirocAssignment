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
        HStack(alignment: .center, spacing: 12) {
            AsyncImage(url: URL(string: product.thumbnail)) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 80, height: 80)

            VStack(alignment: .leading, spacing: 4) {
                Text(product.title)
                    .font(.headline)
                    .lineLimit(2)

                Text("$\(product.price, specifier: "%.2f")")
                    .font(.subheadline)

                Text("⭐️ \(product.rating, specifier: "%.1f")")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()
        }
        .listRowInsets(EdgeInsets(top: 4, leading: 16, bottom: 4, trailing: 16))
    }
}
