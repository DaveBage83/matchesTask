//
//  MockedProductsService.swift
//  Matches Fashion Test AppTests
//
//  Created by David Bage on 22/11/2022.
//

import XCTest
import Combine
@testable import Matches_Fashion_Test_App

final class MockedProductsService: Mock, ProductsServiceable {
    enum Action: Equatable {
        case getProducts
    }
    
    var sendReviewError: Error?
    
    let actions: MockActions<Action>
    
    init(expected: [Action]) {
        self.actions = .init(expected: expected)
    }
    
    func getProducts() async throws -> [Matches_Fashion_Test_App.Product]? {
        register(.getProducts)
        return nil
    }
}
