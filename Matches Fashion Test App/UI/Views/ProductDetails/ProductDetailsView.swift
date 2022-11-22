//
//  ProductDetailsView.swift
//  Matches Fashion Test App
//
//  Created by David Bage on 21/11/2022.
//

import SwiftUI

struct ProductDetailsView: View {
    @Environment(\.mainWindowSize) var mainWindowSize
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    struct Constants {
        struct Main {
            static let vSpacing: CGFloat = 10
        }
        
        struct ProductImage {
            static let heightMultiplier: CGFloat = 0.6
            static let cornerRadius: CGFloat = 8
        }
        
        struct ProductName {
            static let fontSize: CGFloat = 15
        }
        
        struct PriceStack {
            static let vSpacing: CGFloat = 5
            static let fontSize: CGFloat = 13
        }
        
        struct ToWebButton {
            static let fontSize: CGFloat = 14
            static let vPadding: CGFloat = 12
            static let cornerRadius: CGFloat = 6
        }
    }
    
    @StateObject var viewModel: ProductDetailsViewModel
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: Constants.Main.vSpacing) {
                    productImage
                        .cornerRadius(Constants.ProductImage.cornerRadius)
                    
                    Text(viewModel.productName)
                        .multilineTextAlignment(.center)
                        .font(.system(size: Constants.ProductName.fontSize))
                        .bold()
                    
                    priceStack
                    
                    if let url = viewModel.url {
                        toWebViewButton(url: url)
                    }
                    
                }
                .padding()
                .navigationTitle(Strings.Details.title.localized)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar(content: {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        closeButton
                    }
                })
            }
        }
    }
    
    private var productImage: some View {
        AsyncImage(
            url: viewModel.productImageURL,
            content: { image in
                image.resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: mainWindowSize.height * Constants.ProductImage.heightMultiplier)
            },
            placeholder: {
                Image.productPlaceholder
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: mainWindowSize.height * Constants.ProductImage.heightMultiplier)
            }
        )
    }
    
    private var priceStack: some View {
        VStack(spacing: Constants.PriceStack.vSpacing) {
            Text(viewModel.formattedGbpPrice)
                .multilineTextAlignment(.center)
                .font(.system(size: Constants.PriceStack.fontSize))

            if let convertedRate = viewModel.convertedRate {
                Text(convertedRate)
                    .multilineTextAlignment(.center)
                    .font(.system(size: Constants.PriceStack.fontSize))
                    .bold()
            }
        }
    }
    
    private func toWebViewButton(url: URL) -> some View {
        Link(destination: url, label: {
            Text(Strings.Details.button.localized)
                .font(.system(size: Constants.ToWebButton.fontSize))
                .bold()
                .padding(.vertical, Constants.ToWebButton.vPadding)
                .frame(maxWidth: .infinity)
                .background(Color.button)
                .foregroundColor(.typefaceInvert)
                .cornerRadius(Constants.ToWebButton.cornerRadius)
        })
    }
    
    private var closeButton: some View {
        Button {
            presentationMode.wrappedValue.dismiss()
        } label: {
            Image.closeIcon
                .renderingMode(.template)
                .foregroundColor(.typefacePrimary)
        }
    }
}

struct ProductDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailsView(viewModel: .init(container: .preview, product: .init(name: "Test Product", designer: .init(name: "Test Designer"), url: "www.test.com", price: .init(value: 1000, formattedValue: "£1,000"), galleryImageMaps: [], primaryImageMap: .init(large: .init(url: "")))))
    }
}
