//
//  HomeViewModelTests.swift
//  Matches Fashion Test AppTests
//
//  Created by David Bage on 18/11/2022.
//

import XCTest
import Combine
@testable import Matches_Fashion_Test_App

@MainActor
final class HomeViewModelTests: XCTestCase {
    func test_init() {
        let sut = makeSUT()
        XCTAssertNil(sut.products)
        XCTAssertEqual(sut.selectedCurrency, .gbp)
        XCTAssertNil(sut.selectedProduct)
    }
    
    func test_whenSelectProductTriggered_thenSelectedProductPopulated() {
        let sut = makeSUT()
        XCTAssertNil(sut.selectedProduct)
        sut.selectProduct(Product.mockedData)
        XCTAssertEqual(sut.selectedProduct, Product.mockedData)
    }
    
    func test_whenCurrencySetInAppState_thenSelectedCurrencyUpdated() {
        let sut = makeSUT()
        var cancellables = Set<AnyCancellable>()
        sut.container.appState.value.currencySelected = .eur
        
        sut.$selectedCurrency
            .dropFirst() // Will be .gbp as default
            .first()
            .sink { currency in
                XCTAssertEqual(currency, .eur)
            }
            .store(in: &cancellables)
    }
    
    func test_init_placeholderCardDetailsPopulated() {
        let sut = makeSUT()
        
        XCTAssertEqual(sut.placeholderCardDetails.count, 21)
    }
    
    func makeSUT(container: DIContainer = DIContainer(appState: .init(AppState()), services: .mocked())) -> HomeViewModel {
        let sut = HomeViewModel(container: container)
        trackForMemoryLeaks(sut)
        return sut
    }
}
