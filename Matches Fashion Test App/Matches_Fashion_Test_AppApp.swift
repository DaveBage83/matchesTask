//
//  Matches_Fashion_Test_AppApp.swift
//  Matches Fashion Test App
//
//  Created by David Bage on 18/11/2022.
//

import SwiftUI

@main
struct Matches_Fashion_Test_AppApp: App {
    @State var environment: AppEnvironment = AppEnvironment.bootstrap()
    
    var body: some Scene {
        WindowGroup {
            GeometryReader { proxy in
                HomeView(viewModel: .init(container: environment.container))
                    .environment(\.mainWindowSize, proxy.size)
            }
        }
    }
}
