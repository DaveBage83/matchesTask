# Take-Home Task Project

## Purpose
An application displaying a list of products available to purchase from a luxury fashion brand and enabling users to view additional details of each product, navigate to the products web page and select currencies.

## Future plans - OFFLINE MODE

The application would also benefit from an offline mode. This would be built using Core Data. The groundwork for this has been laid with the core data repository created (which is used for currency caching at the moment). The same layer can be used more widely to store Product models which would allow for offline mode to be built. Once the user connects for the first time (online) we would store the products using thee repository to local storage. This could also be used in much the same way we do currently with the currency as a cache. A timestamp would be stored against the data and when the application starts up, regardless of whether or not the user has connectivity, if the data has been stored recently (within x minutes, as defined by a value in the AppConstants) then we can use the stored data and avoid network calls. If the data is stale and the device is online, we can grab the data from the API and save again to the database, deleting any old data. 

We may need to remove support for currencies in offline mode due to the risk of providing inaccurate data to the customer. Estimated time for offline mode development: 1.5 days dev + 0.5 days testing.

The project has been written in a way which should be scalable and testable. Currently all viewModels are tested, however additional service layer and web repository tests will be added. Due to the way the project has been constructed with dependency injection at the fore, we can create mock repositories and test in this way.

An image cache system can also be built using core data. Binary data would be stored to the database and extracted via the persistent layer.

#### Error handling
I would like to implement some error handling - potentially a toast system, which would be triggered globally by appending errors to a property in the appState so that they can be triggered from anywhere in the app and on any view seamlessly. I would also like to replace currently implemented print statements with a proper logging system, potentially leveraging OSLog.

## Technologies used
This project is written primarily in SwiftUI and uses Apple's Combine framework along with async / await.

## Unit testing
Note that SnapShot tests are included here. When UI is changed, in order for these to work, you will need to:
- run the 'record' tasks first (comment out the 'assert' tasks). This will create a snapshot of the target views. Tests will FAIL at this point
- once recorded, comment out the 'record' tasks and uncomment the 'assert' ones. Run again and tests will compare the new snapshots with those recorded. These should now pass..
NB: some issues have been found previously when running tests on different device models. In these cases you may need to re record the tests for them to pass. Looking into a solution for this. 

## Currencies + caching
The application uses a third party endpoint to get currency data. In order to avoid unnecessary server calls, a cache system has been included via the CurrencyDBRepository. Currencies will be stored locally (using Core Data) and will expire after 20 minutes. After this, whenever the user tries to change currency, cache will be deleted and a new server call triggered to refresh the data. The decision was made to delete the currencies rather than update at this stage because it is important that we do not show customers outdated currency data. If the old currencies are deleted and the network call fails to get the latest currencies, it is preferable to not allow the users to convert rather than presenting false / outdated data.

## API credits
Credit to https://rapidapi.com/collection/currency-converter-exchange-api for the currency data and www.matchesfashion.com for the products.

## Support
The app supports light and dark mode and has been tested on a variety of device sizes. Portrait and landscape mode are also supported.

## iOS version support
The app has been built to be compatible with iOS16+ currently. For a wider release, iOS15 should be supported as a minimum

## Screen shots
<img width="449" alt="Screenshot 2022-11-22 at 17 29 30" src="https://user-images.githubusercontent.com/23376033/203381687-477cac2d-822e-46a6-8c12-66f9b1629536.png">

<img width="440" alt="Screenshot 2022-11-22 at 17 29 45" src="https://user-images.githubusercontent.com/23376033/203381737-151a6510-c64f-4793-9ec8-61ea0a793745.png">

<img width="444" alt="Screenshot 2022-11-22 at 17 30 13" src="https://user-images.githubusercontent.com/23376033/203381825-698b9d12-2b4d-4bb5-a43f-9328748ad510.png">

<img width="883" alt="Screenshot 2022-11-22 at 21 15 58" src="https://user-images.githubusercontent.com/23376033/203422660-c00b7e74-d055-4550-9416-bd340ccae8ee.png">


<img width="443" alt="Screenshot 2022-11-22 at 17 30 57" src="https://user-images.githubusercontent.com/23376033/203381950-b08eb35a-727a-4edd-9efa-682825621cc0.png">

<img width="435" alt="Screenshot 2022-11-22 at 17 30 24" src="https://user-images.githubusercontent.com/23376033/203381918-a5a160f0-e604-437a-b1fb-50c2fa6d255d.png">

<img width="692" alt="Screenshot 2022-11-22 at 19 28 50" src="https://user-images.githubusercontent.com/23376033/203404256-6a218b8c-5483-433f-acc3-6d189dbf26c0.png">



<img width="679" alt="Screenshot 2022-11-22 at 19 29 10" src="https://user-images.githubusercontent.com/23376033/203404319-79efbcc5-3baf-4b30-8863-4a9ea3baed2e.png">

<img width="946" alt="Screenshot 2022-11-22 at 19 29 55" src="https://user-images.githubusercontent.com/23376033/203404438-e5852f4a-9824-4cab-a791-6fd1d18f8fd7.png">

<img width="423" alt="Screenshot 2022-11-22 at 20 06 37" src="https://user-images.githubusercontent.com/23376033/203410906-90637a41-5006-4a7a-a906-0b61fd4ead1d.png">

<img width="422" alt="Screenshot 2022-11-22 at 20 05 28" src="https://user-images.githubusercontent.com/23376033/203410715-ac6aa3f8-ac3b-429f-bcd0-4f5b372dce10.png">

### GIF:
![matchesEdited](https://user-images.githubusercontent.com/23376033/203408713-0cb3299b-83b3-484d-a9ba-946a6b016e2f.gif)



