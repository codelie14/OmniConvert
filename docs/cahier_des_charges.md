# 🚀 OmniConvert — Cahier des Charges Complet

> **Version :** 1.0.0
> **Repository :** [github.com/codelie14/OmniConvert](https://github.com/codelie14/OmniConvert)
> **Organisation :** [IndraLabs](https://github.com/Indra-Labs-dev/indralabs-apps)
> **Statut :** En développement actif
> **Plateforme cible :** Desktop (Windows principal, macOS/Linux à venir)
> **Stack :** Flutter Desktop + FFmpeg + Dart

---

## 🧭 Vision du Produit

> **"Le Swiss Army Knife de la conversion — rapide, offline, professionnel."**

OmniConvert est une application desktop **100% offline** qui permet de convertir, compresser, transformer et traiter n'importe quel type de fichier numérique. Conçue pour les développeurs, créateurs de contenu, professionnels et power users, elle mise sur une UI premium, une vitesse d'exécution maximale et une extensibilité totale.

---

## 🎯 Objectifs v1.0.0

| Objectif | Priorité |
|---|---|
| Conversion multi-format (image, audio, vidéo, doc, fichiers dev) | 🔴 Critique |
| Drag & Drop universel avec détection automatique | 🔴 Critique |
| Batch processing | 🔴 Critique |
| UI Desktop premium (3 colonnes) | 🔴 Critique |
| Historique des conversions | 🟠 Haute |
| Profils/Presets de conversion | 🟠 Haute |
| OCR offline (image → texte) | 🟡 Moyenne |
| Système de plugins (architecture) | 🟡 Moyenne |
| Monétisation (Free / Pro) | 🟡 Moyenne |

---

## 🧱 1. MODULES DE CONVERSION

### 📄 Documents

| Source | Cible | Moteur | Notes |
|---|---|---|---|
| PDF | Word (.docx) | `pdf_to_docx` / `pandoc` | Préservation de mise en page |
| Word (.docx) | PDF | `printing` / `pandoc` | Fidélité visuelle |
| TXT | PDF | `pdf` package | Encodage UTF-8 |
| PDF | TXT | `pdftext` | Extraction texte brut |
| Markdown | HTML | `markdown` package | Support GFM |
| HTML | Markdown | `html2md` | Nettoyage tags |
| Markdown | PDF | `pandoc` | Rendu propre |
| EPUB | PDF | `calibre` CLI | Support e-books |

---

### 🖼️ Images

| Source | Cible | Options | Moteur |
|---|---|---|---|
| JPG | PNG / WebP / AVIF / BMP | Qualité, taille | `image` package |
| PNG | JPG / WebP / ICO | Compression sans perte | `image` package |
| WebP | JPG / PNG | — | `image` package |
| SVG | PNG / JPG | Résolution DPI | `flutter_svg` |
| HEIC | JPG / PNG | (iPhone photos) | `heic_to_jpg` |
| GIF | WebP / MP4 | Animation conservée | `ffmpeg` |
| Lot d'images | PDF | Assemblage multi-pages | `pdf` package |
| Image | Texte | **OCR offline** | `tesseract` |
| — | Redimensionnement | px / % / presets | `image` |
| — | Compression intelligente | Qualité cible en KB/MB | `image` |
| — | Conversion couleur | RGB, CMYK, Grayscale | `image` |
| — | Filigrane (watermark) | Texte ou image | `image` |

---

### 🎥 Vidéos

| Source | Cible | Options | Moteur |
|---|---|---|---|
| MP4 | AVI / MKV / MOV / WebM | Codec, bitrate | `ffmpeg` |
| AVI | MP4 / MKV | — | `ffmpeg` |
| MKV | MP4 | — | `ffmpeg` |
| Vidéo | Audio (extraction) | MP3 / AAC / WAV | `ffmpeg` |
| Vidéo | GIF animé | Durée, fps, taille | `ffmpeg` |
| — | Compression vidéo | Cible en MB / qualité CRF | `ffmpeg` |
| — | Changement résolution | 4K→1080p, 720p, 480p | `ffmpeg` |
| — | Changement FPS | 60fps → 30fps | `ffmpeg` |
| — | Découpe (trim) | Début + Fin | `ffmpeg` |
| — | Concaténation | Fusionner plusieurs vidéos | `ffmpeg` |
| — | Ajout sous-titres (SRT) | Burn-in ou softsub | `ffmpeg` |
| — | Capture miniature | Frame à t=X secondes | `ffmpeg` |

---

### 🎵 Audio

| Source | Cible | Options | Moteur |
|---|---|---|---|
| MP3 | WAV / AAC / OGG / FLAC | Bitrate, samplerate | `ffmpeg` |
| WAV | MP3 / AAC | Compression | `ffmpeg` |
| FLAC | MP3 | Lossy compression | `ffmpeg` |
| — | Normalisation volume | Loudness LUFS cible | `ffmpeg` |
| — | Découpe audio | Début + Fin | `ffmpeg` |
| — | Fusion audio | Mixage de pistes | `ffmpeg` |
| — | Extraction canal | Stéréo → Mono | `ffmpeg` |
| — | Changement vitesse | 0.5x → 2x | `ffmpeg` |
| — | Réduction bruit | Filtre passebas | `ffmpeg` |

---

### 📦 Fichiers Dev / Data

| Source | Cible | Notes |
|---|---|---|
| JSON | YAML | Indentation configurable |
| YAML | JSON | Strict ou permissif |
| CSV | JSON | Clés = headers |
| JSON | CSV | Aplatissement objets imbriqués |
| XML | JSON | Attributs conservés |
| JSON | XML | Schéma configurable |
| `.env` | JSON | Export variables |
| SQL dump | CSV | Extraction tables |
| Base64 | Fichier binaire | Decode |
| Fichier binaire | Base64 | Encode |
| Texte | Hash | MD5, SHA1, SHA256 |
| Fichier | Archive ZIP / TAR | Compression |
| Archive | Fichiers | Décompression |

---

### 🔢 Conversions Classiques (Calculateur)

| Catégorie | Unités |
|---|---|
| **Longueur** | km, m, cm, mm, mile, yard, foot, inch |
| **Poids** | kg, g, lb, oz, tonne |
| **Surface** | m², cm², km², hectare, acre, ft² |
| **Volume** | L, mL, m³, gallon, pint, cup |
| **Température** | °C, °F, K |
| **Vitesse** | km/h, m/s, mph, knot |
| **Pression** | Pa, bar, atm, psi |
| **Énergie** | J, kJ, kcal, Wh, kWh |
| **Données** | bit, byte, KB, MB, GB, TB, PB |
| **Temps** | ns, μs, ms, s, min, h, j, semaine |
| **Monnaie** | Taux offline (mis à jour périodiquement via fichier JSON) |
| **Angles** | Degré, radian, gradian |
| **Numériques** | Binaire, Octal, Décimal, Hexadécimal |

---

## 💥 2. FONCTIONNALITÉS DIFFÉRENCIANTES

### ⚡ Drag & Drop Universel
- Glisser n'importe quel fichier → détection automatique du type
- Proposition des conversions disponibles
- Support multi-fichiers simultané
- Zone de drop visuelle avec feedback animé

---

### 🤖 Détection Intelligente
- Analyse MIME type + extension + contenu
- Score de confiance affiché
- Suggestions de conversion classées par pertinence
- Alerte si fichier corrompu ou format non supporté

---

### 📦 Batch Processing
- File d'attente de conversion (queue)
- Progression individuelle et globale
- Pause / Reprise / Annulation
- Rapport de batch (succès / échecs / durée)
- Export du rapport en CSV ou JSON

---

### 📜 Historique des Conversions
- Liste persistante (stockage local SQLite)
- Filtrage par date, type, format source/cible
- Relancer une conversion en 1 clic
- Accès direct au fichier converti
- Statistiques : volume converti, formats les plus utilisés

---

### 🎛️ Profils de Conversion (Presets)
Presets intégrés :

| Nom | Description |
|---|---|
| 📱 WhatsApp | Image <1MB, JPEG 85% |
| 📸 Instagram | 1080px, WebP optimisé |
| ▶️ YouTube | MP4 H.264, 1080p, AAC |
| 📧 Email | Image <500KB, PDF <2MB |
| 🌐 Web Optimisé | WebP, max 1920px |
| 💾 Archivage | Qualité max, sans compression |
| 📟 Dev JSON | JSON minifié |

Presets personnalisés :
- Créer, nommer, sauvegarder ses propres profils
- Import/Export de presets (fichier `.omcp`)
- Partage de presets entre utilisateurs

---

### 🔍 Prévisualisation en Temps Réel
- Aperçu avant/après côte à côte (images)
- Lecteur audio/vidéo intégré
- Différence de taille affichée en %
- Zoom, rotation, comparaison slider pour images

---

### 🔒 Sécurité & Confidentialité
- 100% offline — aucune donnée envoyée en ligne
- Option de suppression automatique des fichiers temporaires
- Chiffrement des fichiers de sortie (AES-256) — *Pro*
- Filigrane automatique — *Pro*

---

### 🌙 Thèmes & Apparence
- Mode sombre / clair / système
- Thèmes de couleur personnalisables (accent color)
- Densité d'affichage (compact / normal / confortable)

---

### 🌐 Internationalisation (i18n)
- 🇫🇷 Français
- 🇬🇧 Anglais
- 🇪🇸 Espagnol
- 🇩🇪 Allemand
- 🇵🇹 Portugais
*(extensible via fichiers ARB)*

---

### ⌨️ Raccourcis Clavier
| Action | Raccourci |
|---|---|
| Nouvelle conversion | `Ctrl+N` |
| Ouvrir fichier | `Ctrl+O` |
| Lancer conversion | `Ctrl+Enter` |
| Batch processing | `Ctrl+B` |
| Historique | `Ctrl+H` |
| Paramètres | `Ctrl+,` |
| Quitter | `Ctrl+Q` |

---

### 🔔 Notifications Desktop
- Notification système à la fin d'une conversion
- Son de confirmation configurable
- Badge sur l'icône (tâches en cours)

---

## 🖥️ 3. INTERFACE UTILISATEUR (UI)

### Layout 3 colonnes

```
┌─────────────────────────────────────────────────────────────────┐
│  🔷 OmniConvert                    [_] [□] [X]              │
├──────────────┬────────────────────────────┬────────────────────┤
│              │                            │                    │
│   SIDEBAR    │       MAIN AREA            │   PREVIEW PANEL    │
│              │                            │                    │
│  🏠 Accueil  │  ┌─────────────────────┐  │  📄 Nom fichier    │
│  📄 Docs     │  │                     │  │  📏 Taille         │
│  🖼️ Images   │  │   DRAG & DROP       │  │  📐 Dimensions     │
│  🎥 Vidéos   │  │       ZONE          │  │  ⚙️ Codec          │
│  🎵 Audio    │  │                     │  │                    │
│  📦 Dev      │  └─────────────────────┘  │  [  Aperçu  ]      │
│  🔢 Calculs  │                            │                    │
│  ─────────  │  Format source → cible     │  Avant | Après     │
│  📜 Historiq │  Options avancées          │                    │
│  ⚙️ Paramèt  │  [  Convertir  ]           │  📊 Diff: -42%     │
│  💎 Pro      │                            │                    │
└──────────────┴────────────────────────────┴────────────────────┘
```

---

### Composants UI principaux

| Composant | Description |
|---|---|
| `DropZone` | Zone de glisser-déposer avec animation |
| `FormatSelector` | Sélecteur source/cible avec icônes |
| `OptionsPanel` | Paramètres dynamiques selon le type |
| `ProgressCard` | Carte de progression par fichier |
| `BatchQueue` | File d'attente visuelle |
| `PreviewPanel` | Aperçu avant/après |
| `HistoryList` | Liste des conversions passées |
| `PresetGrid` | Grille des profils disponibles |
| `StatsWidget` | Statistiques d'utilisation |

---

## ⚙️ 4. STACK TECHNIQUE

### Core

| Technologie | Usage |
|---|---|
| **Flutter 3.x** | Framework UI Desktop |
| **Dart** | Logique applicative |
| **FFmpeg** | Vidéo, Audio, GIF |
| **Pandoc** | Documents (MD, DOCX, PDF) |
| **Tesseract** | OCR offline |
| **SQLite** | Historique local (`sqflite`) |
| **Hive** | Paramètres & Presets |

### Packages Flutter clés

```yaml
dependencies:
  # UI
  flutter_dropzone: ^3.0.0
  window_manager: ^0.3.0
  fluent_ui: ^4.0.0          # ou material3
  
  # Fichiers
  file_picker: ^6.0.0
  path_provider: ^2.1.0
  
  # Images
  image: ^4.0.0
  flutter_svg: ^2.0.0
  
  # Audio/Vidéo
  ffmpeg_kit_flutter: ^6.0.0
  
  # Documents
  pdf: ^3.10.0
  printing: ^5.11.0
  
  # Dev / Data
  yaml: ^3.1.0
  csv: ^5.1.0
  
  # Stockage local
  sqflite: ^2.3.0
  hive_flutter: ^1.1.0
  
  # i18n
  flutter_localizations:
  intl: ^0.18.0
  
  # Utilitaires
  crypto: ^3.0.0
  archive: ^3.4.0
  mime: ^1.0.4
```

---

## 📁 5. ARCHITECTURE DU PROJET

```
lib/
│
├── core/
│   ├── constants/
│   │   ├── app_constants.dart
│   │   ├── conversion_types.dart
│   │   └── supported_formats.dart
│   ├── services/
│   │   ├── file_detection_service.dart
│   │   ├── history_service.dart
│   │   ├── preset_service.dart
│   │   └── notification_service.dart
│   └── utils/
│       ├── file_utils.dart
│       ├── size_formatter.dart
│       └── mime_detector.dart
│
├── features/
│   ├── converter/
│   │   ├── document/
│   │   │   ├── pdf_converter.dart
│   │   │   ├── word_converter.dart
│   │   │   └── markdown_converter.dart
│   │   ├── image/
│   │   │   ├── image_converter.dart
│   │   │   ├── image_compressor.dart
│   │   │   └── ocr_service.dart
│   │   ├── video/
│   │   │   ├── video_converter.dart
│   │   │   ├── video_compressor.dart
│   │   │   └── audio_extractor.dart
│   │   ├── audio/
│   │   │   ├── audio_converter.dart
│   │   │   └── audio_normalizer.dart
│   │   ├── dev/
│   │   │   ├── json_yaml_converter.dart
│   │   │   ├── csv_json_converter.dart
│   │   │   └── base64_converter.dart
│   │   └── units/
│   │       ├── length_converter.dart
│   │       ├── weight_converter.dart
│   │       └── currency_converter.dart
│   │
│   ├── batch/
│   │   ├── batch_controller.dart
│   │   └── batch_report.dart
│   │
│   ├── history/
│   │   ├── history_controller.dart
│   │   └── history_repository.dart
│   │
│   └── settings/
│       ├── settings_controller.dart
│       └── theme_service.dart
│
├── presentation/
│   ├── pages/
│   │   ├── home_page.dart
│   │   ├── history_page.dart
│   │   └── settings_page.dart
│   └── widgets/
│       ├── drop_zone_widget.dart
│       ├── format_selector.dart
│       ├── preview_panel.dart
│       ├── batch_queue_widget.dart
│       ├── preset_card.dart
│       └── stats_widget.dart
│
├── l10n/
│   ├── app_fr.arb
│   ├── app_en.arb
│   └── app_es.arb
│
└── main.dart
```

---

## 🔌 6. SYSTÈME DE PLUGINS (Architecture future)

```dart
abstract class ConversionPlugin {
  String get id;
  String get name;
  String get version;
  List<String> get supportedInputFormats;
  List<String> get supportedOutputFormats;
  Future<ConversionResult> convert(ConversionJob job);
}
```

- Plugins chargés dynamiquement via `.dll` / `.so`
- Marketplace de plugins (IndraLabs Store)
- SDK public pour les développeurs tiers
- Validation & signature des plugins

---

## 💰 7. MONÉTISATION

### Plan Free
- Conversions simples (1 fichier à la fois)
- 5 formats par catégorie
- Historique 7 jours
- Filigrane OmniConvert sur PDF générés

### Plan Pro (abonnement mensuel ou licence perpétuelle)
- ✅ Batch processing illimité
- ✅ Tous les formats
- ✅ Presets personnalisés illimités
- ✅ OCR offline
- ✅ Filigrane personnalisable
- ✅ Chiffrement fichiers sortie
- ✅ Historique illimité
- ✅ Export rapport de batch
- ✅ Priorité support
- ✅ Mises à jour en avance

### Plan Teams (multi-licences)
- Jusqu'à 10 postes
- Tableau de bord admin
- Presets partagés en équipe
- Facturation centralisée

---

## 📊 8. MÉTRIQUES & ANALYTICS (Offline)

Données collectées **localement uniquement** :
- Nombre de conversions par catégorie
- Formats les plus utilisés
- Temps moyen de conversion
- Taux d'échec par format
- Volume total de données traitées

Affichées dans un **Dashboard Statistiques** intégré.

---

## 🗺️ 9. ROADMAP

### v1.0.0 — MVP (actuel)
- [ ] Conversion image (JPG, PNG, WebP)
- [ ] Conversion audio (MP3, WAV, AAC)
- [ ] Conversion vidéo (MP4, AVI, MKV)
- [ ] Drag & Drop basique
- [ ] UI 3 colonnes

### v1.1.0
- [ ] Batch processing
- [ ] Historique SQLite
- [ ] Presets intégrés
- [ ] Conversion documents (PDF ↔ Word)

### v1.2.0
- [ ] OCR offline (Tesseract)
- [ ] Conversions Dev (JSON, YAML, CSV)
- [ ] Calculateur d'unités complet
- [ ] Thèmes clair/sombre

### v1.3.0
- [ ] Internationalisation (FR, EN, ES)
- [ ] Notifications desktop
- [ ] Raccourcis clavier complets
- [ ] Presets personnalisés

### v2.0.0
- [ ] Système de plugins
- [ ] Marketplace IndraLabs
- [ ] Plan Teams
- [ ] macOS + Linux

---

## 🔗 10. INTÉGRATION INDRALABS

OmniConvert fait partie de l'écosystème **IndraLabs** :

```
IndraLabs Apps
├── OmniConvert     ← Ce projet
├── [App 2]
├── [App 3]
└── IndraLabs Hub       ← Launcher commun (futur)
```

- Branding cohérent avec les autres apps IndraLabs
- Authentification partagée (futur)
- Licence cross-apps possible

---

## 📋 11. CONVENTION DE CODE

- **Langue** : Code en anglais, commentaires en français
- **Architecture** : Feature-first + Clean Architecture
- **State management** : Riverpod ou GetX
- **Formatting** : `dart format` + `flutter analyze`
- **Commits** : Conventional Commits (`feat:`, `fix:`, `chore:`)
- **Branches** : `main`, `develop`, `feature/*`, `fix/*`

---

## 📬 12. CONTACT & CONTRIBUTION

- **GitHub :** [codelie14/OmniConvert](https://github.com/codelie14/OmniConvert)
- **Organisation :** [Indra-Labs-dev](https://github.com/Indra-Labs-dev/indralabs-apps)
- **Issues :** Via GitHub Issues
- **Pull Requests :** Bienvenues ! Lire `CONTRIBUTING.md`

---

*© 2026 IndraLabs — OmniConvert v1.0.0*
*Tous droits réservés — Licence propriétaire (Free + Pro)*