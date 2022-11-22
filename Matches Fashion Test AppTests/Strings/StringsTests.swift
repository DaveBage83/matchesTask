//
//  StringsTests.swift
//  Matches Fashion Test AppTests
//
//  Created by David Bage on 22/11/2022.
//

import XCTest
@testable import Matches_Fashion_Test_App

class StringsTests: XCTestCase {
    func checkLocalizedString(key: MatchesString) -> Bool {
        print("\(key) = \(key.localized)")
        return (key.localized == "**\(key)**")
    }
    
    // MARK: - Test standard localisable strings
    
    func testLocalizedStringPresent() {
        Strings.Home.allCases.forEach {
            XCTAssertFalse(checkLocalizedString(key: $0), "\($0) is missing from strings file.")
        }
        
        Strings.Details.allCases.forEach {
            XCTAssertFalse(checkLocalizedString(key: $0), "\($0) is missing from strings file.")
        }
    }
}
