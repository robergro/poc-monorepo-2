# Exemples d'Utilisation des Icônes Générées

## UIKit

### Méthode 1 : Accès Direct via Singleton

```swift
import UIKit

class MyViewController: UIViewController {
    private let imageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Accès direct via le singleton shared
        imageView.image = Iconography.Global.shared.addCircleFill.image
    }
}
```

### Méthode 2 : Avec KeyPath (Recommandé)

```swift
import UIKit

class MyViewController: UIViewController {
    private let imageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Utilisation avec KeyPath - Plus concis et type-safe
        imageView.image = .global(keyPath: \.addCircleFill)
    }
}
```

### Exemple avec Criteria

```swift
import UIKit

class CriteriaCell: UITableViewCell {
    private let iconImageView = UIImageView()

    func configure(withCriteriaIcon icon: KeyPath<Iconography.Criteria, ImageAsset>) {
        iconImageView.image = .criteria(keyPath: icon)
    }
}

// Utilisation
let cell = CriteriaCell()
cell.configure(withCriteriaIcon: \.accessories)
cell.configure(withCriteriaIcon: \.bed)
```

## SwiftUI

### Méthode 1 : Accès Direct

```swift
import SwiftUI

struct MyView: View {
    var body: some View {
        VStack {
            Iconography.Global.shared.addCircleFill.swiftUIImage
                .resizable()
                .frame(width: 24, height: 24)
        }
    }
}
```

### Méthode 2 : Avec KeyPath (Recommandé)

```swift
import SwiftUI

struct MyView: View {
    var body: some View {
        VStack {
            Image.global(keyPath: \.addCircleFill)
                .resizable()
                .frame(width: 24, height: 24)
        }
    }
}
```

### Exemple avec Liste d'Icônes

```swift
import SwiftUI

struct IconListView: View {
    let icons: [KeyPath<Iconography.Global, ImageAsset>] = [
        \.addCircleFill,
        \.alertFill,
        \.bellFill,
        \.heartFill
    ]

    var body: some View {
        List(icons, id: \.hashValue) { iconKeyPath in
            HStack {
                Image.global(keyPath: iconKeyPath)
                    .resizable()
                    .frame(width: 24, height: 24)
                Text("Icon")
            }
        }
    }
}
```

### Exemple avec un Component Réutilisable

```swift
import SwiftUI

struct IconButton: View {
    let iconKeyPath: KeyPath<Iconography.Global, ImageAsset>
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image.global(keyPath: iconKeyPath)
                .resizable()
                .frame(width: 24, height: 24)
        }
    }
}

// Utilisation
IconButton(iconKeyPath: \.addCircleFill) {
    print("Add button tapped")
}
```

## Cas Spéciaux

### Mots-Clés Réservés

Les mots-clés Swift réservés sont automatiquement échappés avec des backticks :

```swift
// Le mot "class" est réservé en Swift
let classIcon = Iconography.Criteria.shared.`class`.image
```

### Noms avec Underscores

```swift
// ThreeDimension_2.imageset devient threeDimension_2
let icon = Iconography.Global.shared.threeDimension_2.image
```

## Catégories Disponibles

- **Global** : Icônes globales (410 icônes)
  ```swift
  Iconography.Global.shared.<iconName>
  ```

- **Criteria** : Icônes de critères (157 icônes)
  ```swift
  Iconography.Criteria.shared.<iconName>
  ```

## Avantages de cette Approche

1. ✅ **Type-Safe** : Erreurs de compilation si l'icône n'existe pas
2. ✅ **Auto-completion** : Xcode suggère les icônes disponibles
3. ✅ **Refactoring** : Renommer une icône met à jour toutes les références
4. ✅ **Centralisé** : Un seul endroit pour gérer toutes les icônes
5. ✅ **Performance** : Pas de recherche par string à runtime
