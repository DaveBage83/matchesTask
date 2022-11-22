//
//  ProductCardViewModel.swift
//  Matches Fashion Test App
//
//  Created by David Bage on 21/11/2022.
//

import Combine
import Foundation

class ProductCardViewModel: ObservableObject {
    @Published var selectedCurrency: CurrencyType = .gbp
    
    private var cancellables = Set<AnyCancellable>()
    let product: Product
    let container: DIContainer
    
    var productName: String {
        product.name
    }
    
    var designerName: String {
        product.designer.name
    }
    
    var galleryImageUrl: URL? {
        guard let urlString = product.galleryImageMaps.first?.large.url else { return nil }
        return URL(string: urlString.urlString)
    }
    
    var formattedGbpPrice: String {
        product.price.formattedValue
    }
    
    var gbpValue: Double {
        product.price.value
    }
    
    var convertedRate: String? {
        // Return nil if selected currency is GBP
        guard selectedCurrency != .gbp, let conversionRate = container.appState.value.currencies?.conversionRates?.filter({ $0.currencyName == selectedCurrency.rawValue }).first?.conversionRate else { return nil }
        
        return gbpValue.toCurrencyString(currencyCode: selectedCurrency.rawValue, rate: conversionRate)
    }
    
    init(container: DIContainer, product: Product) {
        self.container = container
        self.product = product
        let appState = container.appState
        bindCurrencyToAppState(with: appState)
    }
    
    private func bindCurrencyToAppState(with appState: Store<AppState>) {
        appState
            .map(\.currencySelected)
            .receive(on: RunLoop.main)
            .assignWeak(to: \.selectedCurrency, on: self)
            .store(in: &cancellables)
    }
}
