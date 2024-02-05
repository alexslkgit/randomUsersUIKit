# randomUsersUIKit
Random Users Application. Stack: Swift, UIKit, CoreData, Clean Architecture, UnitTests, Data Caching.

## How to test: 
The application has no third-party dependencies so that it can be compiled and run right after opening. The application structure is: 

Screen 1 -> Screen 2 -> Screen 3
Screen 4

Or:

Users list -> User Detail -> User avatar image
Settings Screen

Please swipe in any direction to hide the avatar image on Screen 3.

## Navigation: 
The project is small, so navigation methods are located inside the "View". However, a Router or Coordinator pattern can be used for navigation to separate the navigation layer from the view layer.

## Architecture: 
To ensure an architecture that's easy to test and has no coupled code, all modules are created independently of each other and covered with protocols.

The scheme used is ViewController -> ViewModel -> Network / Data Service. All modules are protocol-based and can be substituted with others with different implementations.

The application is secure using protocols and setting dependencies at object creation time. For example, using ViewModel @propertyWrapper ensures that the ViewController must be created with the value of ViewModel. Otherwise, it will crash.

## Data Caching: 

The process of displaying data: 

1. Cached data from the Core data is displayed. 
2. Requested new data from the API.
3. Core data models are updated with fresh data from the API (only if there is a difference).
4. Updated data from the Core data is displayed.

## Dependency injections: 
Dependency injections are a powerful instrument for testing the code. However the project is small and simple, so DI mechanism present only with initialisation objects. DI can be done without third party libraries, although if project has a few layers of dependencies, it's better to use reliable libraries, like Swinject.

## Multithreading: 
The DispatchQueue functionality is utilized to ensure operation across different threads.
1. All code within UIViewControllers is marked as `@MainActor`. This also applies to all closures that involve UI operations.
2. Data loading in respective services uses Task async await or with DispatchQueue.

## Interface:
Due to this application's small number of UI elements, the interface was created programmatically. All the objects of the user interface are created in UIFactory. It helps to separate the UI layer in the application.
While using Interface Builder can be a good idea for maintaining convenient application development, it has its downsides. 

## Error Handling: 
The application uses data caching; hence, several layers of abstraction within ViewModel are utilized. However, an error propagation mechanism is implemented across all abstraction levels, allowing the user to understand the nature of the issue at any given time.

## External Libraries:
There's no necessity to use external libraries to implement this functionality.

## Testing: 
UnitTests have been added to cover loading, caching, and conversion data operations. Also, the classes are covered with protocols so that new unit tests can be created in the future.
UITests are included to verify the functionality of the user details view. All tests use accessibility identifiers of UI elements.

Tested in Xcode using Leaks and other Xcode instruments.
