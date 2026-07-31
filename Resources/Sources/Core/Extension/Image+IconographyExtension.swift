//
//  Image+IconographyExtension.swift
//  Resources
//
//  Created by robin.lemaire on 31/07/2026.
//

import SwiftUI

public extension Image {

    static func sparkCriteria(keyPath: KeyPath<Iconography.Criteria, ImageAsset>) -> Image {
        return Iconography.Criteria.shared[keyPath: keyPath].swiftUIImage
    }

    static func spark(keyPath: KeyPath<Iconography.Global, ImageAsset>) -> Image {
        return Iconography.Global.shared[keyPath: keyPath].swiftUIImage
    }
}
