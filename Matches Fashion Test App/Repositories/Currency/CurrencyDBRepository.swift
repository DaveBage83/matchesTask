//
//  CurrencyDBRepository.swift
//  Matches Fashion Test App
//
//  Created by David Bage on 20/11/2022.
//

import Combine
import CoreData

protocol CurrencyDBRepositoryProtocol {
    // Get currencies
    func getCurrencies() async -> Result<[CurrencyRates?], Error>
    
    // Create a currency
    func create(currencyRates: CurrencyRates) -> Result<Bool, Error>
    
    // Get expired currencies
    func getCurrenciesForDeletion() async -> Result<[CurrencyRatesMO]?, Error>
    
    // Get expired currencies and delete, return stored currencies if none deleted
    func deleteExpiredAndRetrieveValidCurrencies() async -> Result<[CurrencyRates?]?, Error>
    
    // Delete expired currencies
    func deleteExpiredCurrencies() async -> Result<Bool, Error>
}

class CurrencyDBRepository {
    // Core data currency repository
    private let repository: CoreDataRepository<CurrencyRatesMO>
    
    init(context: NSManagedObjectContext) {
        self.repository = CoreDataRepository<CurrencyRatesMO>(managedObjectContext: context)
    }
}

extension CurrencyDBRepository: CurrencyDBRepositoryProtocol {
    @discardableResult func getCurrencies() async -> Result<[CurrencyRates?], Error> {
        let result = repository.get(predicate: nil, sortDescriptors: nil)
        
        switch result {
        case .success(let currencyRatesMO):
            let currencyRates = currencyRatesMO.map { currencyRateMO -> CurrencyRates? in
                return currencyRatesMO.first?.toDomainModel()
            }
            
            return .success(currencyRates)
        case .failure(let error):
            return .failure(error)
        }
    }
    
    @discardableResult func getCurrenciesForDeletion() async -> Result<[CurrencyRatesMO]?, Error> {
        let query = "timestamp < %@"
        let arguments: [Any] = [
            Calendar.current.date(byAdding: .minute, value: AppConstants.currencyCachedExpiry, to: Date()) ?? Date() as NSDate
        ]
        let predicate = NSPredicate(format: query, argumentArray: arguments)
        
        let result = repository.get(predicate: predicate, sortDescriptors: nil)
        
        switch result {
        case .success(let currencyRatesMO):
            if currencyRatesMO.count == 0 {
                return .success(nil)
            }
            return .success(currencyRatesMO)
        case .failure(let error):
            return .failure(error)
        }
    }
    
    @discardableResult func deleteExpiredAndRetrieveValidCurrencies() async -> Result<[CurrencyRates?]?, Error> {
        // First try to delete expired currencies
        let deleteCurrencies = await deleteExpiredCurrencies()
        
        switch deleteCurrencies {
        case .success:
            // if we have deleted currencies then no need to look for them in the db so exit early
            return .success(nil)
 
        case .failure:
            // means no currencies deleted. We should then get stored currencies
            let storedCurrencies = await getCurrencies()
            
            switch storedCurrencies {
            case .success(let currencies):
                if currencies.count > 0 {
                    return .success(currencies)
                }
                return .success(nil)
            case .failure(let error):
                return .failure(error)
            }
        }
    }
    
    func deleteExpiredCurrencies() async -> Result<Bool, Error> {
        let currenciesToDelete = await getCurrenciesForDeletion()
        
        switch currenciesToDelete {
        case .success(let currenciesToDelete):
            if let currToDelete = currenciesToDelete {
                return repository.delete(entities: currToDelete)
            } else {
                print("No expired currencies")
                return .failure(CoreDataError.invalidManagedObjectType)
            }
            
        case .failure(let error):
            print("Error deleting currencies: \(error)")
            return .failure(error)
        }
    }
    
    func create(currencyRates: CurrencyRates) -> Result<Bool, Error> {
        let result = repository.create()
        switch result {
        case .success(let currencyRatesMO):
            currencyRatesMO.timestamp = Date()

            var rates: [CurrencyMO]?
            
            if let conversionRates = currencyRates.conversionRates {
                rates = conversionRates
                    .reduce(nil, { (ratesArray, record) -> [CurrencyMO]? in
                        var array = ratesArray ?? []
                        if let rate = record.mapToCoreData(in: repository.managedObjectContext) {
                            array.append(rate)
                        }
                        return array
                    })
            }
            
            if let rates {
                currencyRatesMO.rates = NSOrderedSet(array: rates)
            }
            
            do {
                try repository.managedObjectContext.save()
            } catch {
                print("Unable to save context")
            }
            
            print("WE SAVED THE CURRENCIES!")
            return .success(true)
            
        case .failure(let error):
            return .failure(error)
        }
    }
}
