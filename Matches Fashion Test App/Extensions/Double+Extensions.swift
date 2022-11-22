//
//  Double+Extensions.swift
//  Matches Fashion Test App
//
//  Created by David Bage on 21/11/2022.
//

import Foundation

extension Double {
    func toCurrencyString(currencyCode: String, rate: Double) -> String {
        let convertedValue = self * rate
        let formatter = NumberFormatter()
        formatter.currencyCode = currencyCode
        formatter.numberStyle = .currency
        return formatter.string(from: convertedValue as NSNumber) ?? "\(convertedValue)"
    }
}
