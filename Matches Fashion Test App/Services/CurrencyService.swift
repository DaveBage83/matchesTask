//
//  CurrencyService.swift
//  Matches Fashion Test App
//
//  Created by David Bage on 20/11/2022.
//

import Foundation

protocol CurrencyServiceable {
    func getAllCurrencies() async -> CurrencyRates?
}

class CurrencyService: HTTPClient, CurrencyServiceable {
    
    let webRepository: CurrencyWebRepositoryProtocol
    let dbRepository: CurrencyDBRepositoryProtocol
    
    init(webRepository: CurrencyWebRepositoryProtocol, dbRepository: CurrencyDBRepositoryProtocol) {
        self.webRepository = webRepository
        self.dbRepository = dbRepository
    }
    
    func getAllCurrencies() async -> CurrencyRates? {
        // Try to get rates from core data to avoid hitting API constantly
        // I've chosen to delete rather than update here as we should not be showing customers
        // stale exchange rate data (better to disable to service altogether if the network
        // call to get currencies fails after this point)
        let storedCurrencies = await dbRepository.deleteExpiredAndRetrieveValidCurrencies()
        
        switch storedCurrencies {
        case .success(let currRates):
            if let storedRates = currRates?.first {
                return storedRates
            }
        case .failure(let error):
            print("Failed to process stored currencies: \(error)")
        }
                
        let result = await webRepository.getAllCurrencies()
        
        switch result {
        case .success(let success):
            let _ = dbRepository.create(currencyRates: success)
            return success
        case .failure(let failure):
            // Implement error handling here
            print("Failed to get rates \(failure)")
            return nil
        }
    }
}

struct StubCurrencyService: CurrencyServiceable {
    func getAllCurrencies() async -> CurrencyRates? {
        return nil
    }
}
