//
//  String+Extensions.swift
//  Matches Fashion Test App
//
//  Created by David Bage on 19/11/2022.
//

import Foundation

extension String {
    var urlString: String {
        "https:\(self)"
    }
    
    var matchesUrlString: String {
        "https://matchesfashion.com\(self)"
    }
}
