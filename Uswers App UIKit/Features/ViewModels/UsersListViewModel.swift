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
        fetchCachedUsers { [weak self] result in
            switch result {
            case .success():
                self?.fetchUsersFromNetwork(completion: completion)
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
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
