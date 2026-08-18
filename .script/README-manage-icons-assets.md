# Script de Gestion des Assets d'Iconography

Ce script Swift automatise le processus d'importation et d'organisation des icônes SVG depuis un dossier source vers les assets Xcode (`Iconography.xcassets`).

## Description

Le script `generate-iconography-assets.swift` effectue les opérations suivantes :

1. **Nettoie** les dossiers Criteria et Global existants
2. **Importe** tous les fichiers SVG depuis un dossier source
3. **Sépare** automatiquement les icônes en deux catégories :
   - **Criteria** : Icônes contenant "Criteria" dans leur nom
   - **Global** : Toutes les autres icônes
4. **Crée** les imagesets (.imageset) requis par Xcode
5. **Génère** les fichiers Contents.json nécessaires
6. **Configure** les propriétés SVG (vector preservation, template rendering)

## Utilisation

### Syntaxe

```bash
.script/generate-iconography-assets.swift <source-icons-path>
```

ou

```bash
swift .script/generate-iconography-assets.swift <source-icons-path>
```

### Exemple

```bash
.script/generate-iconography-assets.swift spark-token/iconography
```

### Paramètres

- `<source-icons-path>` : Chemin relatif ou absolu vers le dossier contenant les fichiers SVG sources

## Fonctionnement Détaillé

### Étape 1 : Nettoyage
```
✓ Cleared contents of Criteria folder
✓ Cleared contents of Global folder
```

Le script supprime tous les fichiers existants dans les dossiers `Criteria` et `Global` pour éviter les doublons.

### Étape 2 : Lecture des SVG
```
✓ Found 567 SVG files in spark-token/iconography
```

Scanne le dossier source et compte tous les fichiers `.svg`.

### Étape 3 & 4 : Séparation
```
✓ Copied 157 icons to Criteria folder
✓ Copied 410 icons to Global folder
```

Sépare les icônes selon leur nom :
- Si le nom contient "Criteria" → dossier **Criteria** (et supprime "Criteria" du nom)
- Sinon → dossier **Global**

**Exemples de transformation :**
- `AccessoriesCriteria.svg` → `Criteria/Accessories.svg`
- `AddCircleFill.svg` → `Global/AddCircleFill.svg`

### Étape 5 : Création des Imagesets
```
✓ Created 157 imagesets in Criteria folder
✓ Created 410 imagesets in Global folder
```

Pour chaque SVG, crée une structure `.imageset` :
```
AddCircleFill.imageset/
├── AddCircleFill.svg
└── Contents.json
```

Le `Contents.json` généré contient :
```json
{
  "images" : [
    {
      "filename" : "AddCircleFill.svg",
      "idiom" : "universal"
    }
  ],
  "info" : {
    "author" : "xcode",
    "version" : 1
  },
  "properties" : {
    "preserves-vector-representation" : true,
    "template-rendering-intent" : "template"
  }
}
```

### Étape 6 : Configuration des Namespaces
```
✓ Added Contents.json to Criteria folder
✓ Added Contents.json to Global folder
```

Ajoute un `Contents.json` aux dossiers de catégories pour activer les namespaces Xcode.

### Étape 7 : Nettoyage (désactivé)
```
✓ Removed source directory: spark-token/iconography
```

**Note** : Cette étape est actuellement commentée dans le code (ligne 221). Le dossier source n'est pas supprimé.

## Structure Résultante

Après exécution, la structure des assets est :

```
Resources/Sources/Core/Assets/Iconography.xcassets/
├── Contents.json
├── Criteria/
│   ├── Contents.json
│   ├── Accessories.imageset/
│   │   ├── Accessories.svg
│   │   └── Contents.json
│   ├── Attic.imageset/
│   │   ├── Attic.svg
│   │   └── Contents.json
│   └── ... (155 autres)
└── Global/
    ├── Contents.json
    ├── AddCircleFill.imageset/
    │   ├── AddCircleFill.svg
    │   └── Contents.json
    ├── AddCircleOutline.imageset/
    │   ├── AddCircleOutline.svg
    │   └── Contents.json
    └── ... (408 autres)
```

## Workflow Complet

Pour mettre à jour les icônes dans le projet :

### 1. Préparer les Icônes
Placez tous vos fichiers SVG dans un dossier (ex: `spark-token/iconography`).

### 2. Nommer les Icônes
- Utilisez **PascalCase** pour les noms
- Ajoutez le suffixe `Criteria` pour les icônes de critères
- Exemples :
  - `AddCircleFill.svg` → ira dans Global
  - `BedCriteria.svg` → ira dans Criteria (renommé en `Bed.svg`)

### 3. Exécuter le Script de Gestion
```bash
.script/generate-iconography-assets.swift spark-token/iconography
```

### 4. Générer les Classes Swift
```bash
.script/generate-iconography-codebase.swift
```

### 5. Vérifier
```bash
# Vérifier les catégories créées
ls Resources/Sources/Core/Assets/Iconography.xcassets/

# Vérifier le fichier généré
cat Resources/Sources/Core/Extension/Generated/Iconography+Generated.swift
```

### 6. Commiter
```bash
git add Resources/Sources/Core/Assets/Iconography.xcassets/
git add Resources/Sources/Core/Extension/Generated/Iconography+Generated.swift
git commit -m "Update iconography assets"
```

## Conventions de Nommage

### Fichiers Sources
- Format : **PascalCase**
- Extension : `.svg`
- Exemples :
  - ✅ `AddCircleFill.svg`
  - ✅ `AlertOutline.svg`
  - ✅ `BedCriteria.svg`
  - ❌ `add_circle_fill.svg`
  - ❌ `alert-outline.svg`

### Suffixes Recommandés
- **Fill** : Version remplie (`HeartFill.svg`)
- **Outline** : Version en contour (`HeartOutline.svg`)
- **Criteria** : Icône de critère (`BedroomCriteria.svg`)

### Cas Spéciaux
- Les icônes avec `Criteria` dans le nom sont automatiquement déplacées dans le dossier Criteria
- Le suffixe "Criteria" est supprimé du nom final
- `AccessoriesCriteria.svg` devient `Criteria/Accessories.imageset/Accessories.svg`

## Configuration des Propriétés SVG

Le script configure automatiquement les propriétés SVG pour une meilleure intégration iOS :

- **preserves-vector-representation** : `true`
  - Préserve le format vectoriel pour toutes les résolutions

- **template-rendering-intent** : `template`
  - Permet de changer la couleur de l'icône avec `tintColor` (UIKit) ou `.foregroundColor()` (SwiftUI)

## Dépannage

### Erreur : "Source path does not exist"
```bash
❌ Error: Source path does not exist: spark-token/iconography
```

**Solution** : Vérifiez que le chemin vers les icônes sources est correct.

```bash
# Vérifier que le dossier existe
ls -la spark-token/iconography
```

### Erreur : "No SVG files found"
```bash
⚠ No SVG files found in spark-token/iconography
```

**Solution** : Assurez-vous que le dossier contient des fichiers `.svg`.

```bash
# Lister les fichiers SVG
ls spark-token/iconography/*.svg
```

### Les icônes n'apparaissent pas dans Xcode

**Solutions** :
1. Nettoyez le build folder : `Cmd+Shift+K`
2. Supprimez les derived data
3. Relancez Xcode
4. Vérifiez que les `Contents.json` sont valides

### Les icônes apparaissent en noir

**Solution** : Vérifiez que vos SVG sont configurés pour utiliser `currentColor` ou sont compatibles avec le mode template.

## Avantages

- ✅ **Automatisation** : Plus besoin de créer manuellement les imagesets
- ✅ **Organisation** : Séparation automatique Criteria/Global
- ✅ **Cohérence** : Tous les Contents.json suivent le même format
- ✅ **Rapidité** : Traite des centaines d'icônes en quelques secondes
- ✅ **Sans erreur** : Élimine les erreurs de création manuelle

## Améliorations Futures

Idées pour améliorer le script :

1. Support de catégories personnalisées (au-delà de Criteria/Global)
2. Validation des fichiers SVG avant import
3. Optimisation automatique des SVG
4. Génération d'un rapport d'import détaillé
5. Support du mode dry-run pour prévisualiser les changements
