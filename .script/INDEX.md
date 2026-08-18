# Index de la Documentation des Scripts

Documentation complète des scripts de gestion des icônes du projet.

## 📚 Documentation Principale

### [README.md](./README.md)
**Point d'entrée principal** - Vue d'ensemble de tous les scripts et du workflow complet.

**À lire en premier pour** :
- Découvrir tous les scripts disponibles
- Comprendre l'ordre d'exécution
- Voir les liens vers la documentation détaillée

---

## 🛠️ Scripts

### [generate-iconography-assets.swift](./generate-iconography-assets.swift)
Script d'import et d'organisation des icônes SVG vers les assets Xcode.

**Documentation** : [README-manage-icons-assets.md](./README-manage-icons-assets.md)

**Usage** :
```bash
.script/generate-iconography-assets.swift spark-token/iconography
```

**Rôle** :
- Importe les SVG depuis un dossier source
- Sépare automatiquement Criteria/Global
- Crée les imagesets Xcode
- Configure les Contents.json

---

### [generate-iconography-codebase.swift](./generate-iconography-codebase.swift)
Script de génération des classes Swift type-safe pour accéder aux icônes.

**Documentation** : [README-iconography.md](./README-iconography.md)

**Usage** :
```bash
.script/generate-iconography-codebase.swift
```

**Rôle** :
- Scanne Iconography.xcassets
- Génère les structures Swift
- Crée les extensions UIImage/Image
- Produit Iconography+Generated.swift

---

## 📖 Guides

### [WORKFLOW.md](./WORKFLOW.md)
**Guide visuel complet** du workflow de gestion des icônes.

**Contenu** :
- Diagrammes du flux de travail
- Timeline détaillée de chaque étape
- Checklist complète
- Guide de maintenance

**À lire pour** : Comprendre le processus complet de A à Z

---

### [USAGE-EXAMPLE.md](./USAGE-EXAMPLE.md)
**Exemples d'utilisation** des icônes générées dans le code.

**Contenu** :
- Exemples UIKit
- Exemples SwiftUI
- Cas d'usage avancés
- Best practices

**À lire pour** : Savoir comment utiliser les icônes dans votre code

---

## 🎯 Démarrage Rapide

### Première Utilisation

1. **Lire** : [README.md](./README.md)
2. **Comprendre** : [WORKFLOW.md](./WORKFLOW.md)
3. **Importer** : Exécuter `generate-iconography-assets.swift`
4. **Générer** : Exécuter `generate-iconography-codebase.swift`
5. **Utiliser** : Consulter [USAGE-EXAMPLE.md](./USAGE-EXAMPLE.md)

### Référence Rapide

```bash
# Import des icônes
.script/generate-iconography-assets.swift spark-token/iconography

# Génération du code Swift
.script/generate-iconography-codebase.swift

# Utilisation dans le code
UIImage.global(keyPath: \.addCircleFill)           // UIKit
Image.global(keyPath: \.addCircleFill)              // SwiftUI
```

---

## 📊 Structure de la Documentation

```
.script/
│
├── INDEX.md                              ← Vous êtes ici
├── README.md                             ← Point d'entrée principal
│
├── Scripts Swift
│   ├── generate-iconography-assets.swift         ← Import des SVG
│   └── generate-iconography-codebase.swift        ← Génération Swift
│
├── Documentation des Scripts
│   ├── README-manage-icons-assets.md     ← Doc import
│   └── README-iconography.md             ← Doc génération
│
└── Guides
    ├── WORKFLOW.md                       ← Workflow complet
    └── USAGE-EXAMPLE.md                  ← Exemples d'usage
```

---

## 🔍 Trouver ce que vous cherchez

### Je veux...

#### ...importer de nouvelles icônes
→ [README-manage-icons-assets.md](./README-manage-icons-assets.md)

#### ...générer les classes Swift
→ [README-iconography.md](./README-iconography.md)

#### ...comprendre le workflow complet
→ [WORKFLOW.md](./WORKFLOW.md)

#### ...utiliser les icônes dans mon code
→ [USAGE-EXAMPLE.md](./USAGE-EXAMPLE.md)

#### ...voir une vue d'ensemble
→ [README.md](./README.md)

#### ...résoudre un problème
→ Section "Dépannage" dans [README-manage-icons-assets.md](./README-manage-icons-assets.md) ou [README.md](./README.md)

---

## 📈 Statistiques

- **Scripts** : 2
- **Pages de documentation** : 5
- **Exemples de code** : 20+
- **Icônes gérées** : 567 (157 Criteria + 410 Global)
- **Lignes de code générées** : ~640

---

## 🤝 Contribution

Pour améliorer cette documentation :

1. Identifiez ce qui manque ou n'est pas clair
2. Modifiez les fichiers Markdown appropriés
3. Testez que les exemples fonctionnent
4. Mettez à jour l'INDEX.md si nécessaire
5. Soumettez vos modifications

---

## 📝 Changelog

### 2026-07-31
- ✨ Création initiale de la documentation complète
- 📝 Ajout de README.md principal
- 📝 Ajout de README-manage-icons-assets.md
- 📝 Ajout de README-iconography.md
- 📝 Ajout de WORKFLOW.md avec diagrammes
- 📝 Ajout de USAGE-EXAMPLE.md
- 📝 Ajout de INDEX.md (ce fichier)
