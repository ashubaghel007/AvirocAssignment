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
                AsyncImage(url: URL(string: product.image)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 250)

                Text(product.title)
                    .font(.title2)
                    .bold()

                Text(product.category)
                    .foregroundColor(.secondary)

                Text("$\(product.price, specifier: "%.2f")")
                    .font(.title3)
                    .bold()

                Text(product.description)

                Text("Rating: \(product.rating.rate, specifier: "%.1f")")
            }
            .padding()
        }
        .navigationTitle("Details")
    }
}
