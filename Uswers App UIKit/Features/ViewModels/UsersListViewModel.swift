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
    
    func fetchUsers(completion: @escaping () -> ()) {
        fetchCachedUsers { [weak self] in
            self?.fetchUsersFromNetwork(completion: completion)
        }
    }
    
    // MARK: - Private
    
    private func fetchCachedUsers(completion: @escaping () -> ()) {
        coreDataManager.fetchCachedUsers { [weak self] result in
            switch result {
            case .success(let userEntities):
                print(userEntities.count)
                self?.usersArray = userEntities.compactMap { self?.toUIConverter.mapToUI(userEntity: $0) }
            case .failure(let error):
                debugPrint("Failed to fetch cached users: \(error)")
            }
            DispatchQueue.main.async {
                completion()
            }
        }
    }
    
    private func fetchUsersFromNetwork(completion: @escaping () -> ()) {
        networkManager.fetchUsers { [weak self] result in
            switch result {
            case .success(let users):
                self?.storeUsers(users, completion: completion)
            case .failure(let error):
                debugPrint("Failed to fetch users from network: \(error)")
                DispatchQueue.main.async {
                    completion()
                }
            }
        }
    }
    
    private func storeUsers(_ users: [User]?, completion: @escaping () -> ()) {
        guard let users = users else { return }
        coreDataManager.saveUsers(users) { [weak self] error in
            if let error = error {
                debugPrint("Failed to save users: \(error)")
            } else {
                self?.loadFreshData(completion: completion)
            }
        }
    }
    
    private func loadFreshData(completion: @escaping () -> ()) {
        coreDataManager.fetchCachedUsers { [weak self] result in
            switch result {
            case .success(let userEntities):
                self?.usersArray = userEntities.compactMap { self?.toUIConverter.mapToUI(userEntity: $0) }
            case .failure(let error):
                debugPrint("Failed to fetch fresh users: \(error)")
            }
            DispatchQueue.main.async {
                completion()
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
