//
//  CurrencyWebRepository.swift
//  Matches Fashion Test App
//
//  Created by David Bage on 20/11/2022.
//

import Foundation

protocol CurrencyWebRepositoryProtocol {
    func getAllCurrencies() async -> Result<CurrencyRates, RequestError>
}

struct CurrencyWebRepository: HTTPClient, CurrencyWebRepositoryProtocol {
    func getAllCurrencies() async -> Result<CurrencyRates, RequestError> {
        return await sendRequest(endpoint: Endpoints.getExchangeRates, responseModel: CurrencyRates.self, host: AppConstants.currencyHost)
    }
}
