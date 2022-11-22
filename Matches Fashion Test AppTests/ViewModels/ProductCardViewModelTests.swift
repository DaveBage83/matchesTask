//
//  ProductCardViewModelTests.swift
//  Matches Fashion Test AppTests
//
//  Created by David Bage on 22/11/2022.
//

import XCTest
import Combine
@testable import Matches_Fashion_Test_App

final class ProductCardViewModelTests: XCTestCase {
    func test_init() {
        let product = Product.mockedData
        let sut = makeSUT(product: product)
        
        XCTAssertEqual(sut.productName, product.name)
        XCTAssertEqual(sut.designerName, product.designer.name)
        XCTAssertEqual(sut.galleryImageUrl!, URL(string: (product.galleryImageMaps.first?.large.url)!.urlString))
        XCTAssertEqual(sut.formattedGbpPrice, product.price.formattedValue)
        XCTAssertEqual(sut.gbpValue, product.price.value)
    }
    
    func test_init_whenNoGalleryImagePresent_thenGalleryImageURLIsNil() {
        let product = Product.mockedDataNoGalleryImage
        let sut = makeSUT(product: product)
        
        XCTAssertEqual(sut.productName, product.name)
        XCTAssertEqual(sut.designerName, product.designer.name)
        XCTAssertNil(sut.galleryImageUrl)
        XCTAssertEqual(sut.formattedGbpPrice, product.price.formattedValue)
        XCTAssertEqual(sut.gbpValue, product.price.value)
    }
    
    func test_whenSelectedCurrencyIsGBP_thenConvertedRateIsNil() {
        let product = Product.mockedData
        let sut = makeSUT(product: product)
        sut.container.appState.value.currencySelected = .gbp
        XCTAssertNil(sut.convertedRate)
    }
    
    func test_whenSelectedCurrencyIsNotGBP_givenSelectedCurrencyRateIsPresentInAppState_thenConvertedRateReturned() {
        let container = DIContainer(appState: .init(AppState()), services: .mocked())
        container.appState.value.currencies = CurrencyRates.mockedData
        let product = Product.mockedData
        let sut = makeSUT(container: container, product: product)
        sut.selectedCurrency = .eur
        
        XCTAssertEqual(sut.convertedRate, "€1,500.00")
    }
    
    func test_whenSelectedCurrencyIsNotGBP_givenSelectedCurrencyRateIsNOTPresentInAppState_thenConvertedRateNil() {
        let container = DIContainer(appState: .init(AppState()), services: .mocked())
        container.appState.value.currencies = CurrencyRates.mockedData
        let product = Product.mockedData
        let sut = makeSUT(container: container, product: product)
        sut.selectedCurrency = .inr
        
        XCTAssertNil(sut.convertedRate)
    }
    
    func makeSUT(container: DIContainer = DIContainer(appState: .init(AppState()), services: .mocked()), product: Product) -> ProductCardViewModel {
        let sut = ProductCardViewModel(container: container, product: product)
        trackForMemoryLeaks(sut)
        return sut
    }
}
