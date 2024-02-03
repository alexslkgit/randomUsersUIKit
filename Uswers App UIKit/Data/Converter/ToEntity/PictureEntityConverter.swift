//
//  PictureEntityConverter.swift
//  Users App UIKit
//

import CoreData

class PictureEntityConverter: ToEntityConverter {
    
    typealias Input = Picture
    typealias Output = UserPictureEntity

    func convert(input: Picture?, in context: NSManagedObjectContext) -> UserPictureEntity? {
        
        guard let input else { return nil }

        let pictureEntity = UserPictureEntity(context: context)
        pictureEntity.large = input.large
        pictureEntity.medium = input.medium
        pictureEntity.thumbnail = input.thumbnail
        return pictureEntity
    }
}
