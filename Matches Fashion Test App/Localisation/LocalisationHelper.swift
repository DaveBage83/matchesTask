//
//  LocalisationHelper.swift
//  Matches Fashion Test App
//
//  Created by David Bage on 22/11/2022.
//

import Foundation

public protocol MatchesString {
    var localized: String { get }
}

public extension MatchesString where Self: RawRepresentable, Self.RawValue == String {
    
    var localized: String {
        return NSLocalizedString(rawValue, value: "**\(self)**", comment: "")
    }
}
