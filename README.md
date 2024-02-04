# randomUsersUIKit
Random Users Application. Stack: Swift, UIKit, CoreData, Clean Architecture, UnitTests, Data Caching.

## How to test: 
The application has no third-party dependencies so that it can be compiled and run right after opening. The application structure is: 

Screen 1 -> Screen 2 -> Screen 3
Screen 4

## Architecture: 
To ensure an architecture that's easy to test and has no coupled code, all modules are created independently of each other.

The scheme used is ViewController -> ViewModel -> Network / Data Service. All modules are protocol-based and can be substituted with others with different implementations.

The application is secure by using protocols and setting dependencies at object creation time. For example, using ViewModel @propertyWrapper ensures that the ViewController must be created with the value of ViewModel. Otherwise, it will crash.

## Multithreading: 
The DispatchQueue functionality is utilized to ensure operation across different threads.
1. All code within UIViewControllers is marked as `@MainActor`. This also applies to all closures that involve UI operations.
2. Data loading in respective services uses Task async await.

## Interface:
While using Interface Builder can be a good idea for maintaining convenient application development, it has its downsides. 
Due to the small number of UI elements in this application, the interface was created programmatically. All the objects of the user interface are created in UIFactory. It helps to separate UI layer in the application.

## Error Handling: 
The application uses data caching; hence, several layers of abstraction within ViewModel are utilized. However, an error propagation mechanism is implemented across all abstraction levels, allowing the user to understand the nature of the issue at any given time.

## External Libraries:
There's no necessity to use external libraries to implement this functionality.

## Testing: 
UnitTests have been added to cover data operations: loading, caching, and conversion. 
UITests are included to verify the functionality of the user details view. All tests use accessibility identifiers of UI elements.

Tested in Xcode using Leaks and other Xcode instruments.
