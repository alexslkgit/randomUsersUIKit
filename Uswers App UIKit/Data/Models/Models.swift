//
//  Models.swift
//  Uswers App UIKit
//

import Foundation

// MARK: - Welcome
struct RandomUsersList: Codable {
    let results: [User]?
    let info: Info?
}

// MARK: - Info
struct Info: Codable {
    let seed: String?
    let results, page: Int?
    let version: String?
}

// MARK: - Result
struct User: Codable {
    let gender: String?
    let name: Name?
    let location: Location?
    let email: String?
    let phone, cell: String?
    let id: UserID?
    let picture: Picture?
    let nat: String?
}

// MARK: - ID
struct UserID: Codable {
    let name: String?
    let value: String?
}

// MARK: - Location
struct Location: Codable {
    let street: Street?
    let city, state, country: String?
}

// MARK: - Street
struct Street: Codable {
    let number: Int?
    let name: String?
}

// MARK: - Name
struct Name: Codable {
    let title, first, last: String?
}

// MARK: - Picture
struct Picture: Codable {
    let large, medium, thumbnail: String?
}
