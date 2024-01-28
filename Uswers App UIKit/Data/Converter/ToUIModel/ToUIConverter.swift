//
//  ToUIConverter.swift
//  Users App UIKit
//

import Foundation

protocol ToUIConverter {
    func mapToUI(userEntity: UserEntity?) -> UserUI?
}
