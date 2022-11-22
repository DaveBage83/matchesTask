//
//  CurrencyModel.swift
//  Matches Fashion Test App
//
//  Created by David Bage on 20/11/2022.
//

import Foundation
import CoreData

protocol DomainModel {
    associatedtype DomainModelType
    func toDomainModel() -> DomainModelType
}

struct Rate {
    let currencyName: String
    let conversionRate: Double
}

struct CurrencyRates: Codable {
    let timestamp: Date?
    let rates: [String: Double]
    
    // Convert response to array for easier handling with core data
    var conversionRates: [Rate]? {
        var ratesArray = [Rate]()
        rates.forEach { rate in
            ratesArray.append(.init(
                currencyName: rate.key,
                conversionRate: rate.value))
        }
        
        return ratesArray.count > 0 ? ratesArray : nil
    }
}

// Map from core data
extension CurrencyRatesMO: DomainModel {
    func toDomainModel() -> CurrencyRates {
        var currencyRates = [String: Double]()
        
        var conversionRates: [Rate]?
        
        if let rates,
           let storedRates = rates.array as? [CurrencyMO]
        {
            conversionRates = storedRates
                .reduce(nil, { (ratesArray, record) -> [Rate] in
                    var array = ratesArray ?? []
                    if let rate = Rate.mapFromCoreData(record) {
                        array.append(rate)
                    }
                    return array
                })
        }
        
        if let conversionRates {
            conversionRates.forEach { rate in
                currencyRates[rate.currencyName] = rate.conversionRate
            }
        }
        
        return .init(timestamp: timestamp, rates: currencyRates)
    }
}

// Map to core data
extension Rate {
    func mapToCoreData(in context: NSManagedObjectContext) -> CurrencyMO? {
        let storedRate = CurrencyMO(context: context)
        
        storedRate.name = currencyName
        storedRate.rateFromGbp = conversionRate
        
        return storedRate
    }
    
    static func mapFromCoreData(_ storedRate: CurrencyMO?) -> Rate? {
        guard let storedRate = storedRate, let name = storedRate.name else { return nil }
        
        return .init(currencyName: name, conversionRate: storedRate.rateFromGbp)
    }
}
