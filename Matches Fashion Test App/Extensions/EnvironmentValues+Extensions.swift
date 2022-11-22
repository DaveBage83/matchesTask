//
//  EnvironmentValues+Extensions.swift
//  Matches Fashion Test App
//
//  Created by David Bage on 19/11/2022.
//

import SwiftUI

extension EnvironmentValues {
    var mainWindowSize: CGSize {
        get { self[MainWindowSizeKey.self] }
        set { self[MainWindowSizeKey.self] = newValue }
    }
}

private struct MainWindowSizeKey: EnvironmentKey {
    static let defaultValue: CGSize = .zero
}
