//
//  HomeViewModel.swift
//  Matches Fashion Test App
//
//  Created by David Bage on 21/11/2022.
//

import Combine
import Foundation

struct CurrencyOption: Hashable {
    let id = UUID()
    let type: CurrencyType
}

@MainActor
class HomeViewModel: ObservableObject {
    let container: DIContainer
    private var cancellables = Set<AnyCancellable>()
    @Published var products: [Product]?
    @Published var selectedCurrency: CurrencyType = .gbp
    @Published var selectedProduct: Product?
    @Published var isLoading = false
    
    // Hard-coded currencies
    let availableCurrencies: [CurrencyOption] = [
        .init(type: .gbp),
        .init(type: .usd),
        .init(type: .eur),
        .init(type: .jpy),
        .init(type: .inr)
    ]
    
    // Used to present redacted view whilst data is loading
    var placeholderCardDetails: [Product] {
        generateTestProducts()
    }
    
    init(container: DIContainer) {
        self.container = container
        bindCurrencyToAppState()
    }

    func setupHomeView() async {
        isLoading = true
        await getGetAllCurrencies()
        await getWomensProducts()
        isLoading = false
    }
    
    // We use these placeholder cards to show redacted view when first loading
    private func generateTestProducts() -> [Product] {
        var products = [Product]()
        
        for _ in 0...20 {
            products.append(.init(
                name: "Placeholder Product Name", // No need to localise these Strings as they will be redacted
                designer: .init(name: "Placeholder Designer Name"),
                url: "",
                price: .init(value: 1000, formattedValue: "£1,000"),
                galleryImageMaps: [],
                primaryImageMap: .init(large: .init(url: ""))))
        }
        return products
    }
    
    private func getWomensProducts() async {
        do {
            products = try await container.services.productsService.getProducts()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func bindCurrencyToAppState() {
        $selectedCurrency
            .receive(on: RunLoop.main)
            .sink { [weak self] currency in
                guard let self = self else { return }
                self.container.appState.value.currencySelected = currency
                UserDefaults.standard.set(currency.rawValue, forKey: "selectedCurrency")
            }
            .store(in: &cancellables)
    }
    
    func getGetAllCurrencies() async {
        let currencies = await container.services.currencyService.getAllCurrencies()
        container.appState.value.currencies = currencies
    }
    
    func selectProduct(_ product: Product) {
        self.selectedProduct = product
    }
}
