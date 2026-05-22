//
//  Product.swift
//  AvirocAssignment
//
//  Created by Ashish Baghel on 22/05/2026.
//

import Foundation

struct Product: Codable, Identifiable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: String
    let image: String
    let rating: Rating
}

struct Rating: Codable {
    let rate: Double
    let count: Int
}
