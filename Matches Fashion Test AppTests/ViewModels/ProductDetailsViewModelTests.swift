//
//  ProductDetailsViewModelTests.swift
//  Matches Fashion Test AppTests
//
//  Created by David Bage on 22/11/2022.
//

import XCTest
import Combine
@testable import Matches_Fashion_Test_App

final class ProductDetailsViewModelTests: XCTestCase {
    func test_init() {
        let container = DIContainer(appState: .init(.init()), services: .mocked())
        container.appState.value.currencySelected = .eur
        container.appState.value.currencies = .mockedData
        let product = Product.mockedData
        let sut = makeSUT(container: container, product: product)
        
        XCTAssertEqual(sut.productName, product.name)
        XCTAssertEqual(sut.selectedCurrency, .eur)
        XCTAssertEqual(sut.formattedGbpPrice, product.price.formattedValue)
        XCTAssertEqual(sut.gbpValue, product.price.value)
        XCTAssertEqual(sut.url, URL(string: product.url.matchesUrlString))
        XCTAssertEqual(sut.convertedRate, "€1,500.00")
        XCTAssertEqual(sut.productImageURL, URL(string: product.primaryImageMap.large.url.urlString))
    }
    
    func test_whenSelectedCurrencyIsGBP_thenConvertedRateIsNil() {
        let container = DIContainer(appState: .init(.init()), services: .mocked())
        container.appState.value.currencySelected = .gbp
        container.appState.value.currencies = .mockedData
        let product = Product.mockedData
        let sut = makeSUT(container: container, product: product)
        XCTAssertNil(sut.convertedRate)
    }
    
    func test_whenSelectedCurrencyIsNotInAppState_thenConvertedRateIsNil() {
        let container = DIContainer(appState: .init(.init()), services: .mocked())
        container.appState.value.currencySelected = .inr
        container.appState.value.currencies = .mockedData
        let product = Product.mockedData
        let sut = makeSUT(container: container, product: product)
        XCTAssertNil(sut.convertedRate)
    }
    
    func makeSUT(container: DIContainer = DIContainer(appState: .init(AppState()), services: .mocked()), product: Product) -> ProductDetailsViewModel {
        let sut = ProductDetailsViewModel(container: container, product: product)
        trackForMemoryLeaks(sut)
        return sut
    }
}
