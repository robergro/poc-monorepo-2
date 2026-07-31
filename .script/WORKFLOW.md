# Workflow Complet de Gestion des Icônes

Ce document détaille le workflow complet pour gérer les icônes dans le projet, de l'import à l'utilisation.

## Vue d'Ensemble

```
┌──────────────────┐
│  Fichiers SVG    │
│  Sources         │
│                  │
│  spark-token/    │
│  iconography/    │
│  ├─ Icon1.svg    │
│  ├─ Icon2.svg    │
│  └─ ...          │
└────────┬─────────┘
         │
         │ Step 1: Import & Organization
         │ .script/manage-icons-assets.swift
         ▼
┌──────────────────────────────────────┐
│  Iconography.xcassets                │
│                                      │
│  ├─ Criteria/                       │
│  │  ├─ Icon1.imageset/              │
│  │  │  ├─ Icon1.svg                 │
│  │  │  └─ Contents.json             │
│  │  └─ ...                          │
│  │                                  │
│  └─ Global/                         │
│     ├─ Icon2.imageset/              │
│     │  ├─ Icon2.svg                 │
│     │  └─ Contents.json             │
│     └─ ...                          │
└────────┬─────────────────────────────┘
         │
         │ Step 2: Code Generation
         │ .script/generate-iconography.swift
         ▼
┌──────────────────────────────────────┐
│  Iconography+Generated.swift         │
│                                      │
│  struct Iconography {                │
│    struct Criteria { ... }           │
│    struct Global { ... }             │
│  }                                   │
│                                      │
│  extension UIImage { ... }           │
│  extension Image { ... }             │
└────────┬─────────────────────────────┘
         │
         │ Step 3: Usage
         ▼
┌──────────────────────────────────────┐
│  Application Code                    │
│                                      │
│  // UIKit                            │
│  let icon = UIImage.global(          │
│    keyPath: \.addCircleFill          │
│  )                                   │
│                                      │
│  // SwiftUI                          │
│  Image.global(                       │
│    keyPath: \.addCircleFill          │
│  )                                   │
└──────────────────────────────────────┘
```

## Détails du Workflow

### Phase 1 : Préparation des Sources

**Emplacement** : `spark-token/iconography/`

**Actions** :
1. Collectez tous vos fichiers SVG
2. Nommez-les en **PascalCase**
3. Ajoutez le suffixe **Criteria** pour les icônes de critères

**Exemple de structure** :
```
spark-token/iconography/
├── AddCircleFill.svg           # → Global
├── AddCircleOutline.svg        # → Global
├── AlertFill.svg               # → Global
├── BedCriteria.svg             # → Criteria (renommé en Bed.svg)
├── GarageCriteria.svg          # → Criteria (renommé en Garage.svg)
└── ... (565 autres fichiers)
```

### Phase 2 : Import et Organisation

**Script** : `manage-icons-assets.swift`

**Commande** :
```bash
.script/manage-icons-assets.swift spark-token/iconography
```

**Opérations** :

1. **Nettoyage** 🧹
   ```
   Iconography.xcassets/
   ├── Criteria/    [SUPPRIMÉ]
   └── Global/      [SUPPRIMÉ]
   ```

2. **Lecture des Sources** 📖
   ```
   ✓ Found 567 SVG files in spark-token/iconography
   ```

3. **Séparation par Catégorie** 🗂️
   ```
   Analyse du nom de fichier:
   - Contient "Criteria" ? → Dossier Criteria
   - Sinon ? → Dossier Global

   ✓ Copied 157 icons to Criteria folder
   ✓ Copied 410 icons to Global folder
   ```

4. **Création des Imagesets** 📦
   ```
   Pour chaque SVG:
   1. Créer dossier .imageset
   2. Déplacer le SVG dedans
   3. Générer Contents.json

   ✓ Created 157 imagesets in Criteria folder
   ✓ Created 410 imagesets in Global folder
   ```

5. **Configuration** ⚙️
   ```
   Ajout de Contents.json aux dossiers parents:
   ✓ Added Contents.json to Criteria folder
   ✓ Added Contents.json to Global folder
   ```

**Résultat** :
```
Iconography.xcassets/
├── Contents.json
├── Criteria/
│   ├── Contents.json
│   ├── Bed.imageset/
│   │   ├── Bed.svg
│   │   └── Contents.json
│   └── ... (156 autres)
└── Global/
    ├── Contents.json
    ├── AddCircleFill.imageset/
    │   ├── AddCircleFill.svg
    │   └── Contents.json
    └── ... (409 autres)
```

### Phase 3 : Génération du Code Swift

**Script** : `generate-iconography.swift`

**Commande** :
```bash
.script/generate-iconography.swift
```

**Opérations** :

1. **Scan des Assets** 🔍
   ```
   📂 Scanning for icon categories...
   ✅ Found 2 categories:
     - Criteria: 157 icons
     - Global: 410 icons
   ```

2. **Génération des Structures** 🏗️
   ```swift
   internal struct Iconography {
     internal struct Criteria {
       internal let bed = ImageAsset(name: "Criteria/Bed")
       internal let garage = ImageAsset(name: "Criteria/Garage")
       // ... 155 autres

       internal static let shared: Self = .init()
       private init() { }
     }

     internal struct Global {
       internal let addCircleFill = ImageAsset(name: "Global/AddCircleFill")
       internal let addCircleOutline = ImageAsset(name: "Global/AddCircleOutline")
       // ... 408 autres

       internal static let shared: Self = .init()
       private init() { }
     }
   }
   ```

3. **Génération des Extensions** 🔧
   ```swift
   // UIImage extensions
   internal extension UIImage {
     static func criteria(keyPath: KeyPath<Iconography.Criteria, ImageAsset>) -> UIImage
     static func global(keyPath: KeyPath<Iconography.Global, ImageAsset>) -> UIImage
   }

   // SwiftUI Image extensions
   internal extension Image {
     static func criteria(keyPath: KeyPath<Iconography.Criteria, ImageAsset>) -> Image
     static func global(keyPath: KeyPath<Iconography.Global, ImageAsset>) -> Image
   }
   ```

4. **Écriture du Fichier** 💾
   ```
   ✅ Successfully generated:
      Resources/Sources/Core/Extension/Generated/Iconography+Generated.swift

   📊 Statistics:
      - 640 lines
      - 40 KB
      - 567 icon properties
      - 4 extensions
   ```

**Résultat** :
```
Resources/Sources/Core/Extension/Generated/
└── Iconography+Generated.swift    [CRÉÉ/MIS À JOUR]
```

### Phase 4 : Utilisation dans le Code

**Dans UIKit** :

```swift
import UIKit

class MyViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Méthode 1: Accès direct
        let icon1 = Iconography.Global.shared.addCircleFill.image

        // Méthode 2: Via extension (recommandé)
        let icon2 = UIImage.global(keyPath: \.addCircleFill)

        // Utilisation
        imageView.image = icon2
    }
}
```

**Dans SwiftUI** :

```swift
import SwiftUI

struct MyView: View {
    var body: some View {
        VStack {
            // Méthode 1: Accès direct
            Iconography.Global.shared.addCircleFill.swiftUIImage

            // Méthode 2: Via extension (recommandé)
            Image.global(keyPath: \.addCircleFill)
                .resizable()
                .frame(width: 24, height: 24)
        }
    }
}
```

## Timeline Complète

```
┌─────────────────────────────────────────────────────────────────────┐
│ ÉTAPE 1 : Préparation                                              │
├─────────────────────────────────────────────────────────────────────┤
│ • Collecter les SVG                                                │
│ • Nommer en PascalCase                                             │
│ • Ajouter suffixe "Criteria" si nécessaire                         │
│ • Placer dans spark-token/iconography/                             │
│                                                                     │
│ Durée: Variable (selon la source des icônes)                       │
└─────────────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────────────┐
│ ÉTAPE 2 : Import automatique                                       │
├─────────────────────────────────────────────────────────────────────┤
│ Commande:                                                           │
│ $ .script/manage-icons-assets.swift spark-token/iconography        │
│                                                                     │
│ Actions:                                                            │
│ ✓ Nettoyage des dossiers existants                                │
│ ✓ Lecture des SVG sources (567 fichiers)                          │
│ ✓ Séparation Criteria/Global                                       │
│ ✓ Création de 567 imagesets                                        │
│ ✓ Génération des Contents.json                                     │
│                                                                     │
│ Durée: ~5-10 secondes                                              │
└─────────────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────────────┐
│ ÉTAPE 3 : Génération du code Swift                                 │
├─────────────────────────────────────────────────────────────────────┤
│ Commande:                                                           │
│ $ .script/generate-iconography.swift                               │
│                                                                     │
│ Actions:                                                            │
│ ✓ Scan de Iconography.xcassets                                    │
│ ✓ Détection de 2 catégories (Criteria, Global)                    │
│ ✓ Génération de 567 propriétés                                     │
│ ✓ Génération de 4 extensions                                       │
│ ✓ Écriture de Iconography+Generated.swift                         │
│                                                                     │
│ Durée: ~1-2 secondes                                               │
└─────────────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────────────┐
│ ÉTAPE 4 : Utilisation                                              │
├─────────────────────────────────────────────────────────────────────┤
│ • Import du fichier généré dans le projet                          │
│ • Utilisation type-safe dans UIKit/SwiftUI                         │
│ • Auto-completion disponible                                       │
│ • Compilation sans erreur                                          │
│                                                                     │
│ Durée: Immédiate                                                   │
└─────────────────────────────────────────────────────────────────────┘
```

## Checklist Complète

### Avant de Commencer
- [ ] Tous les SVG sont prêts
- [ ] Les noms suivent le PascalCase
- [ ] Les suffixes "Criteria" sont corrects
- [ ] Les SVG sont valides et optimisés

### Import
- [ ] Exécuter `manage-icons-assets.swift`
- [ ] Vérifier le nombre d'icônes importées
- [ ] Vérifier les dossiers Criteria et Global
- [ ] Vérifier quelques imagesets manuellement

### Génération
- [ ] Exécuter `generate-iconography.swift`
- [ ] Vérifier le fichier généré
- [ ] Vérifier le nombre de lignes (~640)
- [ ] Vérifier quelques propriétés

### Test
- [ ] Le projet compile sans erreur
- [ ] Les icônes s'affichent correctement
- [ ] L'auto-completion fonctionne
- [ ] Les couleurs (tint) fonctionnent

### Commit
- [ ] Git add des assets
- [ ] Git add du fichier généré
- [ ] Commit avec message descriptif
- [ ] Push vers le repository

## Maintenance

### Ajouter des Icônes
1. Ajouter les SVG dans `spark-token/iconography/`
2. Relancer les 2 scripts
3. Vérifier et commiter

### Modifier des Icônes
1. Remplacer les SVG dans `spark-token/iconography/`
2. Relancer les 2 scripts
3. Vérifier et commiter

### Supprimer des Icônes
1. Supprimer les SVG de `spark-token/iconography/`
2. Relancer les 2 scripts
3. Rechercher les utilisations dans le code
4. Mettre à jour le code si nécessaire
5. Vérifier et commiter

## Avantages du Workflow

- ✅ **Automatisé** : Pas de manipulation manuelle des assets
- ✅ **Type-Safe** : Détection des erreurs à la compilation
- ✅ **Rapide** : Import de centaines d'icônes en quelques secondes
- ✅ **Cohérent** : Format uniforme pour tous les assets
- ✅ **Maintenable** : Facile d'ajouter/modifier/supprimer des icônes
- ✅ **Documenté** : Chaque étape est claire et reproductible
