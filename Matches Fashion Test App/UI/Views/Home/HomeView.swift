//
//  ContentView.swift
//  Matches Fashion Test App
//
//  Created by David Bage on 18/11/2022.
//

import SwiftUI

enum CurrencyType: String {
    case gbp = "GBP"
    case usd = "USD"
    case eur = "EUR"
    case jpy = "JPY"
    case inr = "INR"
    
    var icon: Image {
        switch self {
        case .gbp:
            return Image.CurrencyIcon.gbp
        case .usd:
            return Image.CurrencyIcon.usd
        case .eur:
            return Image.CurrencyIcon.eur
        case .jpy:
            return Image.CurrencyIcon.jpy
        case .inr:
            return Image.CurrencyIcon.inr
        }
    }
}

struct HomeView: View {
    @Environment(\.mainWindowSize) var mainWindowSize
    
    // MARK: - Constants
    struct Constants {
        struct Grid {
            static let spacing: CGFloat = 20
            static let minCardWidth: CGFloat = 150
        }
    }
    
    // MARK: - View model
    @StateObject var viewModel: HomeViewModel
    
    // MARK: - Grid layout
    var columns: [GridItem] {
        [GridItem(.adaptive(minimum: Constants.Grid.minCardWidth))]
    }
    
    // MARK: - Main body
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: Constants.Grid.spacing) {
                    productCards
                }
                .padding()
            }
            .navigationTitle(Strings.Home.title.localized)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing) {
                    currencyMenu
                }
            })
        }
        .navigationViewStyle(StackNavigationViewStyle()) // Prevents split screen on iPadOS
        .task {
            await viewModel.setupHomeView()
        }
        .sheet(item: $viewModel.selectedProduct) { product in
            ProductDetailsView(viewModel: .init(container: viewModel.container, product: product))
        }
    }
    
    @ViewBuilder private var productCards: some View {
        if viewModel.isLoading {
            ForEach(viewModel.placeholderCardDetails, id: \.self) { product in
                ProductCard(viewModel: .init(container: viewModel.container, product: product))
                    .redacted(reason: viewModel.isLoading ? .placeholder: [])
            }
        } else if let products = viewModel.products {
            ForEach(products, id: \.self) { product in
                ProductCard(viewModel: .init(container: viewModel.container, product: product))
                    .onTapGesture {
                        viewModel.selectProduct(product)
                    }
            }
        }
    }
    
    // MARK: - Currency selection
    private var currencyMenu: some View {
        Menu {
            Picker("", selection: $viewModel.selectedCurrency) {
                ForEach(viewModel.availableCurrencies, id: \.id) { curr in
                    Text(curr.type.rawValue).tag(curr.type)
                }
            }
        } label: {
            viewModel.selectedCurrency.icon
                .renderingMode(.template)
                .foregroundColor(.typefacePrimary)
        }
        .onTapGesture {
            Task {
                // Refresh currencies when menu tapped if they are stale
                await viewModel.getGetAllCurrencies()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: .init(container: .preview))
    }
}
