//
//  Product.swift
//  AvirocAssignment
//
//  Created by Ashish Baghel on 22/05/2026.
//

import Foundation

struct ProductResponse: Codable {
    let products: [Product]
    let total: Int
    let skip: Int
    let limit: Int
}

// MARK: - Product
struct Product: Codable, Identifiable {
    let id: Int
    let title: String
    let description: String
    let category: String
    let price: Double
    let discountPercentage: Double
    let rating: Double
    let stock: Int
    let tags: [String]
    let brand: String?
    let sku: String
    let weight: Int
    let dimensions: Dimensions
    let warrantyInformation: String
    let shippingInformation: String
    let availabilityStatus: String
    let reviews: [Review]
    let returnPolicy: String
    let minimumOrderQuantity: Int
    let meta: Meta?
    let images: [String]
    let thumbnail: String
}

// MARK: - Dimensions

struct Dimensions: Codable {
    let width: Double
    let height: Double
    let depth: Double
}

// MARK: - Review

struct Review: Codable, Identifiable {
    let id = UUID()
    
    let rating: Int
    let comment: String
    let date: String
    let reviewerName: String
    let reviewerEmail: String
    
    enum CodingKeys: String, CodingKey {
        case rating
        case comment
        case date
        case reviewerName
        case reviewerEmail
    }
}

// MARK: - Meta
struct Meta: Codable {
    let createdAt: String
    let updatedAt: String
    let barcode: String
    let qrCode: String
}
