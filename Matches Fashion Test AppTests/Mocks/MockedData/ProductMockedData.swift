//
//  ProductMockedData.swift
//  Matches Fashion Test AppTests
//
//  Created by David Bage on 22/11/2022.
//

import Foundation
@testable import Matches_Fashion_Test_App

extension Product {
    static let mockedData = Product(
        name: "Test Product 1",
        designer: .init(name: "Test Designer"),
        url: "www.test.com",
        price: .init(value: 1000, formattedValue: "£1,000"),
        galleryImageMaps: [.init(large: .init(url: "/www.test.com"))],
        primaryImageMap: .init(large: .init(url: "")))
    
    static let mockedData2 = Product(
        name: "Test Product 1",
        designer: .init(name: "Test Designer"),
        url: "www.test.com",
        price: .init(value: 1000, formattedValue: "£1,000"),
        galleryImageMaps: [],
        primaryImageMap: .init(large: .init(url: "")))
    
    static let mockedDataNoGalleryImage = Product(
        name: "Test Product 1",
        designer: .init(name: "Test Designer"),
        url: "www.test.com",
        price: .init(value: 1000, formattedValue: "£1,000"),
        galleryImageMaps: [],
        primaryImageMap: .init(large: .init(url: "")))
    
    static let mockedProductsArrayData = [
        mockedData,
        mockedData2
    ]
}
