//
//  ProductModel.swift
//  Matches Fashion Test App
//
//  Created by David Bage on 18/11/2022.
//

import Foundation

struct ProductSearchResults: Codable, Hashable {
    let results: [Product]
}

struct Product: Codable, Hashable, Identifiable {
    let id = UUID()
    let name: String
    let designer: Designer
    let url: String
    let price: Price
    let galleryImageMaps: [ProductImage]
    let primaryImageMap: ProductImage
}

struct ProductImage: Codable, Hashable {
    let large: ImageContents
}

struct ImageContents: Codable, Hashable {
    let url: String
}

struct Designer: Codable, Hashable {
    let name: String
}

struct Price: Codable, Hashable {
    let value: Double
    let formattedValue: String
}
