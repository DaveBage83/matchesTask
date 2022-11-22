//
//  ProductCard.swift
//  Matches Fashion Test App
//
//  Created by David Bage on 19/11/2022.
//

import SwiftUI

struct ProductCard: View {
    // MARK: - Constants
    struct Constants {
        struct Main {
            static let hPadding: CGFloat = 8
        }
        
        struct ProductImage {
            static let vSpacing: CGFloat = 10
            static let height: CGFloat = 200
            static let cornerRadius: CGFloat = 8
        }
        
        struct DeisgnerTitle {
            static let fontSize: CGFloat = 15
        }
        
        struct ProductTitle {
            static let fontSize: CGFloat = 13
        }
        
        struct PriceStack {
            static let vSpacing: CGFloat = 5
            static let fontSize: CGFloat = 13
        }
    }
    
    // MARK: - View model
    @StateObject var viewModel: ProductCardViewModel
    
    // MARK: - Main body
    var body: some View {
        VStack(spacing: Constants.ProductImage.vSpacing) {
            productImage
                .cornerRadius(Constants.ProductImage.cornerRadius)
            
            Text(viewModel.designerName)
                .font(.system(size: Constants.DeisgnerTitle.fontSize, weight: .bold))
            
            Text(viewModel.productName)
                .multilineTextAlignment(.center)
                .font(.system(size: Constants.ProductTitle.fontSize))
            
            Spacer()
            
            priceStack
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.vertical)
        .padding(.horizontal, Constants.Main.hPadding)
        .background(Color.cardBackground)
        .standardCardFormat()
    }
    
    // MARK: - Main image
    private var productImage: some View {
        AsyncImage(
            url: viewModel.galleryImageUrl,
            content: { image in
                image.resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: Constants.ProductImage.height)
            },
            placeholder: {
                Image.productPlaceholder
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: Constants.ProductImage.height)
            }
        )
    }
    
    // MARK: - Price details
    private var priceStack: some View {
        VStack(spacing: Constants.PriceStack.vSpacing) {
            Text(viewModel.formattedGbpPrice)
                .font(.system(size: Constants.PriceStack.fontSize))
            if let convertedRate = viewModel.convertedRate {
                Text(convertedRate)
                    .font(.system(size: Constants.PriceStack.fontSize))
                    .bold()
            } else {
                Text("0") // Ensures spacing remains same regardless of whether second currency displayed or not
                    .foregroundColor(.clear)
                    .font(.system(size: Constants.PriceStack.fontSize))
            }
        }
    }
}

struct ProductCard_Previews: PreviewProvider {
    static var previews: some View {
        ProductCard(viewModel: .init(container: .preview, product: Product(
            name: "Leather backless loafers",
            designer: .init(name: "Mr Cool"),
            url: "www.test.com",
            price: .init(value: 1380, formattedValue: "£1,380"),
            galleryImageMaps: [
                .init(large: .init(url: ""))
            ], primaryImageMap: .init(large: .init(url: "")))))
    }
}
