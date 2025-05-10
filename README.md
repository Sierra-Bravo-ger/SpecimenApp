# SpecimenOne

Eine vollständig offline-fähige Flutter-App für medizinische Einrichtungen, die als Leistungsverzeichnis für Labortests dient.

## Projektübersicht

SpecimenOne ist eine Cross-Platform-Anwendung für medizinische Einrichtungen, die umfassende Informationen zu Labortests bereitstellt. Die App wurde von einer React-basierten PWA zu einer nativen Flutter-Anwendung migriert, um eine bessere Performance und vollständige Offline-Funktionalität zu gewährleisten.

### Hauptfunktionen

- **Vollständige Offline-Funktionalität**: Alle Daten werden lokal gespeichert und sind jederzeit verfügbar
- **Schnelle Suche**: Einfache Suche nach Tests anhand von Namen oder Synonymen
- **Kategorisierte Tests**: Übersichtliche Darstellung der Tests nach Kategorien
- **Detaillierte Informationen**: Umfassende Informationen zu jedem Test, einschließlich Referenzwerten
- **Mehrsprachige Unterstützung**: Vorbereitet für mehrsprachige Inhalte

## Technische Details

### Plattformen

- **Primär**: Android, iOS
- **Sekundär**: Windows
- **Nicht priorisiert**: Web

### Architektur

Die App folgt einer modularen Architektur mit klarer Trennung von Daten, Geschäftslogik und Präsentation:

- **Datenmodelle**: Definiert in `lib/data/models/`
- **Repositories**: Verwalten den Datenzugriff in `lib/data/repositories/`
- **UI-Komponenten**: Screens und Widgets in `lib/presentation/`
- **Core-Funktionalitäten**: Datenbank, Konstanten und Themes in `lib/core/`

### Datenbank

- **Hive**: Eine schnelle, leichtgewichtige NoSQL-Datenbank für lokale Datenspeicherung
- **SQLite**: Als alternative Option implementiert

### Abhängigkeiten

Die wichtigsten Abhängigkeiten sind:

- **UI**: Flutter Material Design, Flutter SVG
- **Zustandsverwaltung**: Provider, Flutter Bloc
- **Lokale Datenbank**: Hive, SQLite
- **Netzwerk**: HTTP, Connectivity Plus
- **Hilfspakete**: Intl, JSON Serializable, UUID, Logger

## Installation und Einrichtung

### Voraussetzungen

- Flutter SDK (Version 3.7.2 oder höher)
- Dart SDK (Version 3.0.0 oder höher)
- Android Studio oder Visual Studio Code mit Flutter-Erweiterungen

### Installation

1. Repository klonen:
   ```
   git clone https://github.com/Sierra-Bravo-ger/SpecimenApp.git
   ```

2. Abhängigkeiten installieren:
   ```
   flutter pub get
   ```

3. Code-Generierung ausführen:
   ```
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. App starten:
   ```
   flutter run
   ```

## Projektstruktur

```
lib/
├── core/
│   ├── constants/       # App-Konstanten
│   ├── database/        # Datenbankhelfer (Hive, SQLite)
│   └── theme/           # App-Theme und Styling
├── data/
│   ├── models/          # Datenmodelle
│   └── repositories/    # Datenzugriffsschicht
└── presentation/
    ├── screens/         # App-Screens
    └── widgets/         # Wiederverwendbare UI-Komponenten
```

## Datenquellen

Die App verwendet JSON-Dateien als initiale Datenquelle:

- `assets/data/tests.json`: Enthält alle Labortests
- `assets/data/einheiten.json`: Enthält alle Einheiten
- `assets/data/material.json`: Enthält alle Materialien
- `assets/data/referenzwerte.json`: Enthält alle Referenzwerte
- Weitere Dateien für zusätzliche Daten

## Zukünftige Erweiterungen

- Synchronisation mit einem Backend-Server
- Favoriten-Funktion für häufig verwendete Tests
- Export-Funktion für Testergebnisse
- Barcode-Scanner zur schnellen Testidentifikation

## Lizenz

Dieses Projekt ist urheberrechtlich geschützt. © 2025
