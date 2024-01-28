//
//  LocationEntityConverter.swift
//  Users App UIKit
//

import Foundation
import CoreData

class LocationEntityConverter: ToEntityConverter {
    
    typealias Input = Location
    typealias Output = UserLocationEntity

    func convert(input: Location?, in context: NSManagedObjectContext) -> UserLocationEntity? {
        
        guard let input else { return nil }
        
        let locationEntity = UserLocationEntity(context: context)
        locationEntity.cityName = input.city
        locationEntity.state = input.state
        locationEntity.country = input.country
        return locationEntity
    }
}
