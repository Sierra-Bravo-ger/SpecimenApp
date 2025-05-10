/// Konstanten für die gesamte Anwendung
class AppConstants {
  // App-Informationen
  static const String appName = 'SpecimenOne';
  static const String appVersion = '1.0.0';
  static const String appDescription =
      'Offline-fähiges Leistungsverzeichnis für medizinische Einrichtungen';

  // Datenbank-Informationen
  static const String databaseName = 'specimen_one.db';
  static const int databaseVersion = 1;

  // Hive Box Namen
  static const String testsBox = 'tests';
  static const String einheitenBox = 'einheiten';
  static const String materialBox = 'material';
  static const String profileBox = 'profile';
  static const String referenzwerteBox = 'referenzwerte';
  static const String empfaengerBox = 'empfaenger';
  static const String farbenBox = 'farben';
  static const String versandartBox = 'versandart';

  // API Endpunkte (falls später benötigt)
  static const String baseUrl = 'https://one.madmoench.de';
  static const String apiVersion = 'v1';

  // Pfade zu lokalen Assets
  static const String testsJsonPath = 'assets/data/tests.json';
  static const String einheitenJsonPath = 'assets/data/einheiten.json';
  static const String materialJsonPath = 'assets/data/material.json';
  static const String profileJsonPath = 'assets/data/profile.json';
  static const String referenzwerteJsonPath = 'assets/data/referenzwerte.json';
  static const String empfaengerJsonPath = 'assets/data/empfaenger.json';
  static const String farbenJsonPath = 'assets/data/farben.json';
  static const String versandartJsonPath = 'assets/data/versandart.json';

  // Einstellungen
  static const String prefsKeyFirstRun = 'first_run';
  static const String prefsKeyLastSync = 'last_sync';

  // Kategorien für Tests
  static const List<String> testKategorien = [
    'Klinische Chemie',
    'Hämatologie',
    'Immunologie',
    'Infektserologie',
    'Gerinnung',
    'Urinstatus',
    'Toxikologie',
    'Allergie',
    'Versand',
    'Elektrophorese',
  ];
}
