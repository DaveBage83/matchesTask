//
//  MockedDIContainer.Services.swift
//  Matches Fashion Test AppTests
//
//  Created by David Bage on 22/11/2022.
//

import XCTest
@testable import Matches_Fashion_Test_App

extension DIContainer.Services {
    enum ServiceType {
        case products
        case currency
    }
    
    static func mocked(
        productsService: [MockedProductsService.Action] = [],
        currencyService: [MockedCurrencyService.Action] = []
    ) -> DIContainer.Services {
        .init(
            productsService: MockedProductsService(expected: productsService),
            currencyService: MockedCurrencyService(expected: currencyService)
        )
    }
    
    func verify(as serviceType: ServiceType, file: StaticString = #file, line: UInt = #line) {
        switch serviceType {
        case .currency:
            (currencyService as? MockedCurrencyService)?
                .verify(file: file, line: line)
        case .products:
            (productsService as? MockedProductsService)?
                .verify(file: file, line: line)
        }
    }
}
