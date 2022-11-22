//
//  AppState.swift
//  Matches Fashion Test App
//
//  Created by David Bage on 21/11/2022.
//

import Foundation

// We can use the appState further to control, for example, state-driven UI
struct AppState {
    var currencies: CurrencyRates?
    var currencySelected: CurrencyType = .gbp
}
