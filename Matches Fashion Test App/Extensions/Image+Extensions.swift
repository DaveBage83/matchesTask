//
//  Image+Extensions.swift
//  Matches Fashion Test App
//
//  Created by David Bage on 19/11/2022.
//

import SwiftUI

extension Image {
    static let productPlaceholder = Image("productPlaceholder")
    static let currencyIcon = Image(systemName: "dollarsign.arrow.circlepath")
    static let closeIcon = Image(systemName: "xmark.circle")
    
    struct CurrencyIcon {
        static let gbp = Image(systemName: "sterlingsign.circle")
        static let usd = Image(systemName: "dollarsign.circle")
        static let eur = Image(systemName: "eurosign.circle")
        static let jpy = Image(systemName: "yensign.circle")
        static let inr = Image(systemName: "indianrupeesign.circle")
    }
}
