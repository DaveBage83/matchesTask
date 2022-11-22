//
//  ProductsWebRepository.swift
//  Matches Fashion Test App
//
//  Created by David Bage on 22/11/2022.
//

import Foundation

protocol ProductsWebRepositoryProtocol {
    func getWomensProducts() async -> Result<ProductSearchResults, RequestError>
}

struct ProductsWebRepository: HTTPClient, ProductsWebRepositoryProtocol {
    func getWomensProducts() async -> Result<ProductSearchResults, RequestError> {
        return await sendRequest(endpoint: Endpoints.getWomensItems, responseModel: ProductSearchResults.self, host: AppConstants.matchesFashionHost)
    }
}
