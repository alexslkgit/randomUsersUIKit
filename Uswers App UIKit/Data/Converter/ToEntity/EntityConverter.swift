//
//  DataConverter.swift
//  Users App UIKit
//

import CoreData

protocol ToEntityConverter {
    
    associatedtype Input
    associatedtype Output
    
    func convert(input: Input?, in context: NSManagedObjectContext) -> Output?
}
