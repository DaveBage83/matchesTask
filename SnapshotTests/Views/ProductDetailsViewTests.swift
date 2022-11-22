//
//  ProductDetailsViewTests.swift
//  Matches Snapshot Tests
//
//  Created by David Bage on 22/11/2022.
//

import XCTest
import SwiftUI
@testable import Matches_Fashion_Test_App

class ProductDetailsViewTests: XCTestCase {
    func test_init_light() {
        let sut = makeSUT()
        let iPhone12Snapshot = sut.snapshot(for: .iPhone12(style: .light))
        let iPad8thGenSnapshot = sut.snapshot(for: .iPad8thGen(style: .light))
        let iPhone14ProMaxSnapshot = sut.snapshot(for: .iPhone14ProMax(style: .light))
        let iPad12_9ProSnapShot = sut.snapshot(for: .iPad12_9Pro(style: .light))

        // Record - Comment out when asserting
//        record(snapshot: iPad8thGenSnapshot, sut: sut)
//        record(snapshot: iPhone12Snapshot, sut: sut)
//        record(snapshot: iPad12_9ProSnapShot, sut: sut)
//        record(snapshot: iPhone14ProMaxSnapshot, sut: sut)

        // Assert - Comment out when recording
        assert(snapshot: iPad8thGenSnapshot, sut: sut)
        assert(snapshot: iPhone12Snapshot, sut: sut)
        assert(snapshot: iPad12_9ProSnapShot, sut: sut)
        assert(snapshot: iPhone14ProMaxSnapshot, sut: sut)
    }
    
    func makeSUT() -> ProductDetailsView {
        .init(viewModel: .init(container: .preview, product: .mockedData))
    }
}
