//
//  UsersListPresenter.swift
//  Users App UIKit
//

import Foundation
import Foundation

class UsersListPresenter {
    
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
    
    func fetchUsers() async throws {
        try await fetchCachedUsers()
        try await fetchUsersFromNetwork()
    }
    
    // MARK: - Private
    
    private func fetchCachedUsers() async throws {
        let data = try await coreDataManager.fetchCachedUsers()
        self.usersArray = data.compactMap { self.toUIConverter.mapToUI(userEntity: $0) }
    }
    
    private func fetchUsersFromNetwork() async throws {
        let users = try await networkManager.fetchUsers()
        try await storeUsers(users)
    }
    
    // MARK: Storing Data
    
    private func storeUsers(_ users: [User]?) async throws {
        guard let users = users else { return }
        
        try await coreDataManager.saveUsers(users)
        try await loadFreshData()
    }
    
    private func loadFreshData() async throws {
        let data = try await coreDataManager.fetchCachedUsers()
        self.usersArray = data.compactMap { self.toUIConverter.mapToUI(userEntity: $0) }
    }
    
    // MARK: - Public
    
    func numberOfRowsInSection() -> Int {
        return usersArray.count
    }
    
    func cellForRowAt(_ indexPath: IndexPath) -> UserUI {
        return usersArray[indexPath.row]
    }
}

