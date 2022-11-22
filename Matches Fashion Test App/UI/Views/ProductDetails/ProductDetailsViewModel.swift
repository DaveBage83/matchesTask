//
//  ProductDetailsViewModel.swift
//  Matches Fashion Test App
//
//  Created by David Bage on 22/11/2022.
//

import Combine
import Foundation

class ProductDetailsViewModel: ObservableObject {
    let container: DIContainer
    var product: Product
    
    var productName: String {
        product.name
    }
    
    var selectedCurrency: CurrencyType {
        container.appState.value.currencySelected
    }
    
    var formattedGbpPrice: String {
        product.price.formattedValue
    }
    
    var gbpValue: Double {
        product.price.value
    }
    
    var url: URL? {
        return URL(string: product.url.matchesUrlString)
    }
    
    var convertedRate: String? {
        // Return nil if selected currency is GBP
        guard selectedCurrency != .gbp, let conversionRate = container.appState.value.currencies?.conversionRates?.filter({ $0.currencyName == selectedCurrency.rawValue }).first?.conversionRate else { return nil }
        
        return gbpValue.toCurrencyString(currencyCode: selectedCurrency.rawValue, rate: conversionRate)
    }
    
    var productImageURL: URL? {
        let urlString = product.primaryImageMap.large
        return URL(string: urlString.url.urlString)
    }
    
    init(container: DIContainer, product: Product) {
        self.container = container
        self.product = product
    }
}
