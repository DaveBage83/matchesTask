//
//  Endpoints.swift
//  Matches Fashion Test App
//
//  Created by David Bage on 18/11/2022.
//

import Combine
import Foundation

enum Endpoints {
    case getWomensItems
    case getExchangeRates
}

extension Endpoints: Endpoint {
    var path: String {
        switch self {
        case .getWomensItems:
            return "/womens/shop"
        case .getExchangeRates:
            return "/latest"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .getWomensItems, .getExchangeRates:
            return .get
        }
    }
    
    var header: [String : String]? {
        switch self {
        case .getWomensItems:
            return nil
        case .getExchangeRates:
            return [
                "X-RapidAPI-Key": "3244e8d3e4msh5ac653bb150eb02p1f3da1jsn66e99a066db9",
                "X-RapidAPI-Host": "fixer-fixer-currency-v1.p.rapidapi.com"
            ]
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .getWomensItems:
            return [
                .init(name: "format", value: "json")
            ]
        case .getExchangeRates:
            return [.init(name: "base", value: "GBP")] // Currency we only require to convert from gbp
        }
    }
    
    var body: [String: String]? {
        switch self {
        case .getWomensItems, .getExchangeRates:
            return nil
        }
    }
}
