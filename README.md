# Take-Home Task Project

## Purpose
An application displaying a list of products available to purchase from a luxury fashion brand and enabling users to view additional details of each product, navigate to the products web page and select currencies.
This project was created as part of a recruitment process.

## Future plans - OFFLINE MODE

The application would also benefit from an offline mode. This would be built using Core Data. The groundwork for this has been laid with the persistent layer created (which is used for currency caching at the moment). The same layer can be used more widely to store Product models which would allow for offline mode to be built. Once the user connects for the first time (online) we would store the products using the core data layer to local storage. This could also be used in much the same way we do currently with the currency as a cache. A timestamp would be stored against the data and when the application starts up, regardless whether or not the user has connectivity, if the data has been stored recently (within x minutes, as defined by the AppConstants) then we can use that data and avoid network calls. If the data is stale and the device is online, we can grab the data from the API and re-store in the database. 

We may need to remove support for currencies in offline mode due to the risk of providing inaccurate data to the customer. Estimated time for offline mode development: 1.5 days dev + 0.5 days testing.

The project has been written in a way which should be scalable and testable. Currently all viewModels are tested, however additional service layer and web repository tests will be added. Due to the way the project has been constructed with dependency injection at the fore, we can create mock repositories and test in this way.

An image cache system can also be built using core data. Binary data would be stored to the database and extracted via the persistent layer.

## Technologies used
This project is written primarily in SwiftUI and uses Apple's Combine framework along with async / await.

## Unit testing
Note that SnapShot tests are included here. When UI is changed, in order for these to work, you will need to:
- run the 'record' tasks first (comment out the 'assert' tasks). This will create a snapshot of the target views. Tests will FAIL at this point
- once recorded, comment out the 'record' tasks and uncomment the 'assert' ones. Run again and tests will compare the new snapshots with those recorded. These should now pass..
NB: some issues have been found previously when running tests on different device models. In these cases you may need to re record the tests for them to pass. Looking into a solution for this. 

## Currencies
The application uses a third party endpoint to get currency data. In order to avoid unnecessary server calls, a cache system has been included. Currencies will be stored locally (using Core Data) and will expire after 20 minutes. After this, whenever the user tries to change currency, cache will be deleted and a new server call triggered to refresh the data.

## API credits
Credit to https://rapidapi.com/collection/currency-converter-exchange-api for the currency data and www.matchesfashion.com for the products.

## Support
The app supports light and dark mode and has been tested on a variety of device sizes. Portrait and landscape mode are also supported.

## iOS version support
The app has been built to be compatible with iOS16+ currently. For a wider release, iOS15 should be supported as a minimum
