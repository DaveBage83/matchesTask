//
//  Double+ExtensionsTests.swift
//  Matches Fashion Test AppTests
//
//  Created by David Bage on 22/11/2022.
//

import XCTest
@testable import Matches_Fashion_Test_App

class Double_ExtensionsTests: XCTestCase {
    func test_toCurrencyString() {
        let doubleValue: Double = 1500
        
        let currencyString = doubleValue.toCurrencyString(currencyCode: "EUR", rate: 1.5)
        
        XCTAssertEqual(currencyString, "€2,250.00")
    }
}
