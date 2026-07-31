//
//  UIImage+IconographyExtension.swift
//  Resources
//
//  Created by robin.lemaire on 31/07/2026.
//

import UIKit

public extension UIImage {

    static func sparkCriteria(keyPath: KeyPath<Iconography.Criteria, ImageAsset>) -> UIImage {
        return Iconography.Criteria.shared[keyPath: keyPath].image
    }

    static func spark(keyPath: KeyPath<Iconography.Global, ImageAsset>) -> UIImage {
        return Iconography.Global.shared[keyPath: keyPath].image
    }
}
