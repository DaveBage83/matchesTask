//
//  Modifiers.swift
//  Matches Fashion Test App
//
//  Created by David Bage on 19/11/2022.
//

import SwiftUI

struct StandardCardFormat: ViewModifier {
    @Binding var isDisabled: Bool
    
    func body(content: Content) -> some View {
        content
            .cornerRadius(8)
            .shadow(color: isDisabled ? .clear : .gray, radius: 3, x: 0, y: 0) // When in disabled state we do not want to apply shadow
    }
}

extension View {
    func standardCardFormat(isDisabled: Binding<Bool> = .constant(false)) -> some View {
        modifier(StandardCardFormat(isDisabled: isDisabled))
    }
}
