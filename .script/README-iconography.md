# Script de Génération d'Iconography

Ce script Swift génère automatiquement les classes d'accès à l'iconography à partir des assets dans `Iconography.xcassets`.

## Utilisation

Pour générer les fichiers Swift d'accès à l'iconography :

```bash
.script/generate-iconography-codebase.swift
```

## Sortie

Le script génère un fichier :
- `Resources/Sources/Core/Iconography/Iconography+Generated.swift`

Ce fichier contient :
- Une structure `Iconography` avec des sous-structures pour chaque catégorie d'icônes
- Chaque propriété utilise `ImageAsset` (qui doit être défini ailleurs)

**Note** : Le script ne génère plus :
- La structure `ImageAsset` (à définir dans un fichier séparé)
- Les extensions `UIImage` et `SwiftUI.Image` (à créer manuellement si nécessaire)

## Structure Générée

```swift
public struct Iconography {
  public struct Global {
    public let addCircleFill = ImageAsset(name: "Global/AddCircleFill")
    public let addCircleOutline = ImageAsset(name: "Global/AddCircleOutline")
    // ... autres icônes

    public static let shared: Self = .init()
    private init() { }
  }

  public struct Criteria {
    public let accessories = ImageAsset(name: "Criteria/Accessories")
    // ... autres icônes

    public static let shared: Self = .init()
    private init() { }
  }
}
```

## Utilisation des Icônes Générées

### Prérequis

Vous devez créer un fichier `ImageAsset.swift` avec la structure suivante :

```swift
public struct ImageAsset {
  public fileprivate(set) var name: String

  public var image: UIImage {
    let bundle = Bundle.module
    guard let result = UIImage(named: name, in: bundle, compatibleWith: nil) else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }

  public var swiftUIImage: Image {
    Image(name, bundle: .module)
  }
}
```

### UIKit

```swift
// Accès direct via ImageAsset
let imageAsset = Iconography.Global.shared.addCircleFill
let image = imageAsset.image
```

### SwiftUI

```swift
// Accès direct via ImageAsset
let imageAsset = Iconography.Global.shared.addCircleFill
let image = imageAsset.swiftUIImage
```

## Fonctionnalités

- ✅ Détection automatique de tous les dossiers d'icônes dans `Iconography.xcassets`
- ✅ Conversion automatique des noms en camelCase (AddCircleFill → addCircleFill)
- ✅ Gestion des mots-clés Swift réservés (class, do, import) avec backticks
- ✅ Génération de structures avec pattern Singleton (`.shared`)
- ✅ Code `public` pour une utilisation inter-modules
- ✅ Fichiers organisés dans `Resources/Sources/Core/Iconography/`

## Notes

- Le fichier généré est marqué avec `// DO NOT EDIT` car il est automatiquement régénéré
- Le script doit être exécuté depuis la racine du projet
- Les icônes sont triées alphabétiquement dans chaque catégorie
- **Important** : Vous devez créer manuellement le fichier `ImageAsset.swift`
- Les extensions UIImage/Image doivent être créées manuellement si vous souhaitez utiliser les KeyPaths

## Fichiers Requis

### ImageAsset.swift (à créer manuellement)

Créez ce fichier dans votre projet :

```swift
// ImageAsset.swift
import UIKit
import SwiftUI

public struct ImageAsset {
  public fileprivate(set) var name: String

  public var image: UIImage {
    let bundle = Bundle.module
    guard let result = UIImage(named: name, in: bundle, compatibleWith: nil) else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }

  public var swiftUIImage: Image {
    Image(name, bundle: .module)
  }
}
```

### Extensions (optionnelles)

Si vous souhaitez utiliser les KeyPaths, créez ces extensions :

```swift
// UIImage+Iconography.swift
public extension UIImage {
  static func global(keyPath: KeyPath<Iconography.Global, ImageAsset>) -> UIImage {
    return Iconography.Global.shared[keyPath: keyPath].image
  }

  static func criteria(keyPath: KeyPath<Iconography.Criteria, ImageAsset>) -> UIImage {
    return Iconography.Criteria.shared[keyPath: keyPath].image
  }
}

// Image+Iconography.swift
public extension Image {
  static func global(keyPath: KeyPath<Iconography.Global, ImageAsset>) -> Image {
    return Iconography.Global.shared[keyPath: keyPath].swiftUIImage
  }

  static func criteria(keyPath: KeyPath<Iconography.Criteria, ImageAsset>) -> Image {
    return Iconography.Criteria.shared[keyPath: keyPath].swiftUIImage
  }
}
```
