//
//  AppEnvironment.swift
//  Matches Fashion Test App
//
//  Created by David Bage on 18/11/2022.
//

struct AppEnvironment {
    // Injectable container allowing for services to be accessible throughout app and for testing
    let container: DIContainer
}

extension AppEnvironment {
    static func bootstrap() -> AppEnvironment {
        let webRepositories = configuredWebRepositories()
        let dbRepositories = configuredDBRepositories()
        let appState = Store<AppState>(AppState())
        
        let services = configuredServices(webRepositories: webRepositories, dbRepositories: dbRepositories)

        let diContainer = DIContainer(
            appState: appState,
            services: services
        )
        
        return AppEnvironment(container: diContainer)
    }
    
    private static func configuredServices(webRepositories: DIContainer.WebRepositories, dbRepositories: DIContainer.DBRepositories) -> DIContainer.Services {
                
        let productsService = ProductsService(webRepository: webRepositories.productsWebRepository)
        let currencyService = CurrencyService(webRepository: webRepositories.currencyWebRepository, dbRepository: dbRepositories.currencyDBRepository)
        
        return .init(
            productsService: productsService,
            currencyService: currencyService
        )
    }
    
    private static func configuredWebRepositories() -> DIContainer.WebRepositories {
        let currencyWebRepository = CurrencyWebRepository()
        let productsWebRepository = ProductsWebRepository()
        return .init(currencyWebRepository: currencyWebRepository,
                     productsWebRepository: productsWebRepository)
    }
    
    private static func configuredDBRepositories() -> DIContainer.DBRepositories {
        // Context
        let persistentStore = CoreDataContextProvider().viewContext
        
        let currencyDBRepository = CurrencyDBRepository(context: persistentStore)
        
        return .init(
            currencyDBRepository: currencyDBRepository
        )
    }
}

extension DIContainer {
    struct WebRepositories {
        let currencyWebRepository: CurrencyWebRepository
        let productsWebRepository: ProductsWebRepository
    }
    
    struct DBRepositories {
        let currencyDBRepository: CurrencyDBRepository
    }
}
