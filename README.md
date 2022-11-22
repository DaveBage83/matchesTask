# Take-Home Task Project

## Purpose
An application displaying a list of products available to purchase from a luxury fashion brand and enabling users to view additional details of each product, navigate to the products web page and select currencies.
This project was created as part of a recruitment process.

## Technologies used
This project is written primarily in SwiftUI and uses Apple's Combine framework along with async / await.

## Unit testing
Note that SnapShot tests are included here. In order for these to work, you will need to:
- run the 'record' tasks first (comment out the 'assert' tasks). This will create a snapshot of the target views. Tests will FAIL at this point
- once recorded, comment out the 'record' tasks and uncomment the 'assert' ones. Run again and tests will compare the new snapshots with those recorded. These should now pass..

## Currencies
The application uses a third party endpoint to get currency data. In order to avoid unnecessary server calls, a cache system has been included. Currencies will be stored locally (using Core Data) and will expire after 20 minutes. After this, whenever the user tries to change currency, cache will be deleted and a new server call triggered to refresh the data.

## API credits
Credit to https://rapidapi.com/collection/currency-converter-exchange-api for the currency data and www.matchesfashion.com for the products.

## Future plans
The project has been written in a way which should be scalable and testable. Currently all viewModels are tested, however additional service layer and web repository tests will be added. Due to the way the project has been constructed with dependency injection at the fore, we can create mock repositories and test in this way.
