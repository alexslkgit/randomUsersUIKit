//
//  UsersListViewModel.swift
//  Users App UIKit
//

import Foundation

class UsersListViewModel {
    
    private var usersArray: [UserUI] = []
    
    private var networkManager: NetworkManager
    private let coreDataManager: CoreDataManager
    private let toUIConverter: ToUIConverter
    
    init(coreDataManager: CoreDataManager,
         networkManager: NetworkManager,
         toUIConverter: ToUIConverter) {
        self.coreDataManager = coreDataManager
        self.networkManager = networkManager
        self.toUIConverter = toUIConverter
    }
    
    func fetchUsers(completion: @escaping (Result<Void, Error>) -> Void) {
        Task {
            fetchCachedUsers { [weak self] result in
                guard let self else { return }
                switch result {
                case .success():
                    completion(.success(()))
                    self.fetchUsersFromNetwork(completion: completion)
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    // MARK: - Private
    
    private func fetchCachedUsers(completion: @escaping (Result<Void, Error>) -> Void) {
        
        coreDataManager.fetchCachedUsers { [weak self] result in
            switch result {
            case .success(let userEntities):
                self?.usersArray = userEntities.compactMap { self?.toUIConverter.mapToUI(userEntity: $0) }
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func fetchUsersFromNetwork(completion: @escaping (Result<Void, Error>) -> Void) {
        networkManager.fetchUsers { [weak self] result in
            switch result {
            case .success(let users):
                self?.storeUsers(users, completion: completion)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // MARK: Storing Data
    
    private func storeUsers(_ users: [User]?, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let users = users else { return }
        coreDataManager.saveUsers(users) { [weak self] error in
            if let error = error {
                completion(.failure(error))
            } else {
                self?.loadFreshData(completion: completion)
            }
        }
    }
    
    private func loadFreshData(completion: @escaping (Result<Void, Error>) -> Void) {
        coreDataManager.fetchCachedUsers { [weak self] result in
            switch result {
            case .success(let userEntities):
                self?.usersArray = userEntities.compactMap { self?.toUIConverter.mapToUI(userEntity: $0) }
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // MARK: - Public
    
    func numberOfRowsInSection() -> Int {
        return usersArray.count
    }
    
    func cellForRowAt(_ indexPath: IndexPath) -> UserUI {
        return usersArray[indexPath.row]
    }
}
/*
    We would have liked to see “The Fresh Stack” as well. (SwiftUI)
    The application is not prepared to work in Dark Mode.
    Not possible to follow the development process in the git history of the repo.
    Nice encapsulated and extracted object creation login using factories.
 
    For the NetworkManager: It was preferred prefer use async-await, but completionHandler works fine. That class does too much IMHO. Mapping the user’s response should be extracted.
 
    The created ViewModels seem to function more like Presenters, as it is not possible to see a binding mechanism. Also, there are no Unit Tests for the view models.
    The navigation from UsersList to UsersDetails is implemented in UsersListViewController, so this feature is not agnostic of UserDetails.
    Good use of abstractions and injected the interfaces instead of concrete logic. In UsersListViewModel maybe by mistake, he injected concrete core data, which in this case is also leaking framework implementation details (CoreData).
    CoreData - deletion use case is missing. In this case, it is important to save users in a clean state. And of course, testing this use case is missing.
    DataManager and NetworkManager should conform to the same protocol for fetching data. It is an implementation detail that one fetches from the remote and the other one from the cache.
    Overuse of patterns
 */
