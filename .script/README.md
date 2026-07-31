# Scripts de Gestion du Projet

Ce dossier contient les scripts d'automatisation pour la gestion des ressources du projet.

## Scripts Disponibles

### 1. `manage-icons-assets.swift`
**Gestion des Assets d'Iconography**

Importe et organise automatiquement les icônes SVG depuis un dossier source vers les assets Xcode.

```bash
.script/manage-icons-assets.swift spark-token/iconography
```

📖 **Documentation complète** : [README-manage-icons-assets.md](./README-manage-icons-assets.md)

**Fonctionnalités** :
- Nettoie les dossiers Criteria et Global
- Importe automatiquement les SVG
- Sépare les icônes selon leur nom (Criteria vs Global)
- Crée les imagesets Xcode
- Configure les propriétés SVG

---

### 2. `generate-iconography.swift`
**Génération des Classes Swift d'Accès**

Génère automatiquement les classes Swift type-safe pour accéder aux icônes.

```bash
.script/generate-iconography.swift
```

📖 **Documentation complète** : [README-iconography.md](./README-iconography.md)

**Fonctionnalités** :
- Scanne tous les imagesets dans Iconography.xcassets
- Génère des structures Swift public avec pattern Singleton
- Conversion automatique en camelCase
- Gestion des mots-clés Swift réservés

**Sortie** :
- `Resources/Sources/Core/Iconography/Iconography+Generated.swift`

**Note** : Ce script génère uniquement les structures. Vous devez créer manuellement :
- `ImageAsset.swift` (structure publique pour encapsuler les assets)
- Extensions UIImage/Image (si vous souhaitez utiliser les KeyPaths)

---

## Workflow Complet : Mise à Jour des Icônes

Pour mettre à jour les icônes du projet, suivez ces étapes dans l'ordre :

### Étape 1 : Importer les Icônes
Utilisez le script de gestion des assets pour importer vos SVG :

```bash
.script/manage-icons-assets.swift spark-token/iconography
```

**Résultat** :
- ✅ Icônes organisées dans `Iconography.xcassets/Criteria/` et `Iconography.xcassets/Global/`
- ✅ Imagesets créés avec Contents.json

### Étape 2 : Générer les Classes Swift
Générez les classes d'accès Swift :

```bash
.script/generate-iconography.swift
```

**Résultat** :
- ✅ Fichier `Iconography+Generated.swift` créé/mis à jour

### Étape 3 : Créer les Fichiers Requis (une seule fois)
Créez les fichiers nécessaires (si ce n'est pas déjà fait) :

**ImageAsset.swift** :
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

### Étape 4 : Vérifier
Vérifiez que tout fonctionne :

```bash
# Vérifier les assets
ls Resources/Sources/Core/Resources/Iconography.xcassets/Global/*.imageset | wc -l
ls Resources/Sources/Core/Resources/Iconography.xcassets/Criteria/*.imageset | wc -l

# Vérifier le fichier généré
cat Resources/Sources/Core/Iconography/Iconography+Generated.swift | head -50
```

### Étape 5 : Utiliser
Utilisez les icônes dans votre code :

```swift
// UIKit - Accès direct
let image = Iconography.Global.shared.addCircleFill.image

// SwiftUI - Accès direct
Iconography.Global.shared.addCircleFill.swiftUIImage

// Avec KeyPaths (nécessite des extensions)
let image = UIImage.global(keyPath: \.addCircleFill)
Image.global(keyPath: \.addCircleFill)
```

📖 **Exemples d'utilisation** : [USAGE-EXAMPLE.md](./USAGE-EXAMPLE.md)

---

## Structure des Fichiers

```
.script/
├── README.md                           # Ce fichier
├── manage-icons-assets.swift           # Script d'import des icônes
├── generate-iconography.swift          # Script de génération Swift
├── README-manage-icons-assets.md       # Doc du script d'import
├── README-iconography.md               # Doc du script de génération
└── USAGE-EXAMPLE.md                    # Exemples d'utilisation des icônes
```

---

## Documentation Détaillée

### Scripts
- [📖 manage-icons-assets.swift](./README-manage-icons-assets.md) - Import et organisation des SVG
- [📖 generate-iconography.swift](./README-iconography.md) - Génération des classes Swift

### Guides
- [📖 Exemples d'Utilisation](./USAGE-EXAMPLE.md) - Comment utiliser les icônes dans UIKit et SwiftUI

---

## Conventions de Nommage

### Fichiers SVG Sources
- Format : **PascalCase**
- Suffixe "Criteria" pour les critères
- Extension : `.svg`

**Exemples** :
```
AddCircleFill.svg        → Global/addCircleFill
AlertOutline.svg         → Global/alertOutline
BedCriteria.svg          → Criteria/bed
AccessoriesCriteria.svg  → Criteria/accessories
```

### Classes Swift Générées
- Format : **camelCase**
- Mots-clés réservés échappés avec backticks

**Exemples** :
```swift
Iconography.Global.shared.addCircleFill    // AddCircleFill.svg
Iconography.Criteria.shared.bed            // BedCriteria.svg
Iconography.Criteria.shared.`class`        // ClassCriteria.svg
```

---

## Maintenance

### Ajouter de Nouvelles Icônes

1. Placez vos SVG dans `spark-token/iconography/`
2. Nommez-les en PascalCase
3. Ajoutez "Criteria" au nom si c'est un critère
4. Exécutez les deux scripts :
   ```bash
   .script/manage-icons-assets.swift spark-token/iconography
   .script/generate-iconography.swift
   ```

### Créer une Nouvelle Catégorie

Pour ajouter une catégorie au-delà de Criteria/Global :

1. Créez le dossier manuellement dans `Iconography.xcassets/`
2. Ajoutez un `Contents.json` avec `provides-namespace: true`
3. Ajoutez vos imagesets
4. Lancez `generate-iconography.swift`

La nouvelle catégorie sera automatiquement détectée et intégrée.

---

## Dépannage

### Problème : Les icônes n'apparaissent pas

**Solutions** :
1. Vérifiez que les scripts ont été exécutés dans l'ordre
2. Nettoyez le build : `Cmd+Shift+K`
3. Supprimez les derived data
4. Relancez Xcode

### Problème : Erreur de compilation

**Solutions** :
1. Vérifiez que le fichier généré est bien importé dans le projet
2. Vérifiez qu'il n'y a pas de conflit de noms
3. Relancez `generate-iconography.swift`

### Problème : Les icônes sont en noir

**Solutions** :
1. Vérifiez que vos SVG utilisent `currentColor`
2. Vérifiez que `template-rendering-intent` est à `template`
3. Utilisez `.renderingMode(.template)` en SwiftUI

---

## Contribution

Pour contribuer à l'amélioration de ces scripts :

1. Testez vos modifications
2. Mettez à jour la documentation
3. Ajoutez des exemples si nécessaire
4. Créez une pull request

---

## Ressources

- [Apple - Asset Catalog Format](https://developer.apple.com/library/archive/documentation/Xcode/Reference/xcode_ref-Asset_Catalog_Format/)
- [Apple - Working with Vector Images](https://developer.apple.com/documentation/uikit/uiimage/providing_images_for_different_appearances)
- [SwiftUI Image Documentation](https://developer.apple.com/documentation/swiftui/image)
