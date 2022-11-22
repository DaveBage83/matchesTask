//
//  Strings.swift
//  Matches Fashion Test App
//
//  Created by David Bage on 22/11/2022.
//

import Foundation

typealias IterableMatchesString = MatchesString & CaseIterable

public enum Strings {
    public enum Home: String, IterableMatchesString {        
        case title = "home.title"
    }
    
    public enum Details: String, IterableMatchesString {
        case title = "productdetails.title"
        case button = "productdetails.button"
    }
}
