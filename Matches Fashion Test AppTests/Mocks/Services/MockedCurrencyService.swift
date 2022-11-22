//
//  MockedCurrencyService.swift
//  Matches Fashion Test AppTests
//
//  Created by David Bage on 22/11/2022.
//

import XCTest
import Combine
@testable import Matches_Fashion_Test_App

final class MockedCurrencyService: Mock, CurrencyServiceable {
    enum Action: Equatable {
        case getAllCurrencies
        case convertCurrency(initialValue: Double, rate: Double)
    }
    
    var sendReviewError: Error?
    
    let actions: MockActions<Action>
    
    init(expected: [Action]) {
        self.actions = .init(expected: expected)
    }
    
    func getAllCurrencies() async -> Matches_Fashion_Test_App.CurrencyRates? {
        register(.getAllCurrencies)
        return .init(timestamp: Date(), rates: ["USD": 1.2])
    }
    
    func convertCurrency(initialValue: Double, rate: Double) -> Double {
        register(.convertCurrency(initialValue: initialValue, rate: rate))
        return 2
    }
}
