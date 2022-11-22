//
//  CurrenciesMockedData.swift
//  Matches Fashion Test AppTests
//
//  Created by David Bage on 22/11/2022.
//

import Foundation
@testable import Matches_Fashion_Test_App

extension CurrencyRates {
    static let mockedData = CurrencyRates(
        timestamp: Date(),
        rates: ["EUR": 1.5])
}
