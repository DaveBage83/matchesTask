//
//  DIContainer.swift
//  Matches Fashion Test App
//
//  Created by David Bage on 18/11/2022.
//

import SwiftUI

struct DIContainer: EnvironmentKey {
    let services: Services
    let appState: Store<AppState>
    
    static var defaultValue: Self { Self.default }
    
    private static let `default` = DIContainer(appState: .init(AppState()), services: .stub)
    
    init(appState: Store<AppState>, services: DIContainer.Services) {
        self.appState = appState
        self.services = services
    }
}

extension DIContainer {
    struct Services {
        let productsService: ProductsServiceable
        let currencyService: CurrencyServiceable
        
        init(
            productsService: ProductsServiceable,
            currencyService: CurrencyServiceable
        ) {
            self.productsService = productsService
            self.currencyService = currencyService
        }
        
        static var stub: Self {
            .init(
                productsService: StubProductsService(),
                currencyService: StubCurrencyService()
            )
        }
    }
}

#if DEBUG
extension DIContainer {
    static var preview: Self {
        .init(appState: .init(AppState()), services: .stub)
    }
}
#endif

