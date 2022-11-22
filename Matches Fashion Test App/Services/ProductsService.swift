//
//  ProductsService.swift
//  Matches Fashion Test App
//
//  Created by David Bage on 18/11/2022.
//

import Foundation

enum ProductsError: Error {
    case unableToFetchProducts
}

extension ProductsError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .unableToFetchProducts:
            return "Unable to fetch products"
        }
    }
}

protocol ProductsServiceable {
    func getProducts() async throws -> [Product]?
}

class ProductsService: HTTPClient, ProductsServiceable {
    let webRepository: ProductsWebRepositoryProtocol

    init(webRepository: ProductsWebRepositoryProtocol) {
        self.webRepository = webRepository
    }
    
    func getProducts() async throws -> [Product]? {
        let response = await webRepository.getWomensProducts()
        switch response {
        case .success(let products):
            return products.results
        case .failure:
            throw ProductsError.unableToFetchProducts
        }
    }
}

struct StubProductsService: ProductsServiceable {
    func getProducts() async -> [Product]? {
        return nil
    }
}
