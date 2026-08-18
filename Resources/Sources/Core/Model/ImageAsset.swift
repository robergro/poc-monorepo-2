//
//  ImageAsset.swift
//  Resources
//
//  Created by robin.lemaire on 31/07/2026.
//

import SwiftUI
import UIKit

public struct ImageAsset: Sendable {

    // MARK: - Properties

  internal fileprivate(set) var name: String

  internal var image: UIImage {
    let bundle = Bundle.current
      guard let result = UIImage(named: self.name, in: bundle, compatibleWith: nil) else {
        fatalError("Unable to load image asset named \(self.name).")
    }
    return result
  }

  internal var swiftUIImage: Image {
      Image(self.name, bundle: .current)
  }
}
