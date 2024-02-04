# randomUsersUIKit
Random Users Application. Stack: Swift, UIKit, CoreData, Clean Architecture, UnitTests, Data Caching.

## Architecture: 
To ensure an architecture that's easy to test and has no coupled code, all modules are created independently of each other.

The scheme used is: ViewController -> ViewModel -> Network / Data Service. All modules are protocol-based and can be substituted with others that have different implementations.

## Multithreading: 
To ensure operation across different threads, the Task async await functionality is utilized.
1. All code within UIViewController is marked as `@MainActor`. This also applies to all closures that involve UI operations.
2. Data loading in respective services uses Task async await.

## Interface:
While using Interface Builder can be a good idea for maintaining code comfort, it comes with its downsides. 
In this application, due to the small number of UI elements, the interface was created programmatically.

## Error Handling: 
The application uses data caching, hence several layers of abstraction within ViewModel are utilized. However, an error propagation mechanism is implemented across all abstraction levels, allowing the user to understand the nature of the issue at any given time.

## External Libraries:
There's no necessity to use external libraries to implement this functionality.

## Testing: 
UnitTests have been added to cover data operations: loading, caching, and conversion. UITests are included to verify the functionality of user details view.
Tested in Xcode using Leaks and other Xcode instruments.
