import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:specimen_one/core/constants/app_constants.dart';
import 'package:specimen_one/data/models/hive_models.dart';

/// HiveHelper verwaltet die Hive-Datenbank für die Offline-Funktionalität
/// Hive ist eine leichtgewichtige und schnelle NoSQL-Datenbank
class HiveHelper {
  static final HiveHelper _instance = HiveHelper._internal();

  factory HiveHelper() => _instance;

  HiveHelper._internal();

  /// Löscht alle Hive-Boxen und deren Daten
  Future<void> deleteBoxes() async {
    try {
      await Hive.deleteBoxFromDisk(AppConstants.testsBox);
      await Hive.deleteBoxFromDisk(AppConstants.einheitenBox);
      await Hive.deleteBoxFromDisk(AppConstants.materialBox);
      await Hive.deleteBoxFromDisk(AppConstants.profileBox);
      await Hive.deleteBoxFromDisk(AppConstants.referenzwerteBox);
      await Hive.deleteBoxFromDisk(AppConstants.empfaengerBox);
      await Hive.deleteBoxFromDisk(AppConstants.farbenBox);
      await Hive.deleteBoxFromDisk(AppConstants.versandartBox);
      print('Alle Hive-Boxen wurden gelöscht');
    } catch (e) {
      print('Fehler beim Löschen der Hive-Boxen: $e');
    }
  }

  /// Initialisiert Hive und registriert die Adapter
  Future<void> init() async {
    await Hive.initFlutter();
    
    // Lösche alte Boxen, um Kompatibilitätsprobleme zu vermeiden
    await deleteBoxes();
    
    // Registriere die Adapter für die Hive-Modelle
    Hive.registerAdapter(HiveLabTestAdapter());
    Hive.registerAdapter(HiveEinheitAdapter());
    Hive.registerAdapter(HiveMaterialAdapter());
    Hive.registerAdapter(HiveProfilAdapter());
    Hive.registerAdapter(HiveReferenzwertAdapter());
    Hive.registerAdapter(HiveEmpfaengerAdapter());
    Hive.registerAdapter(HiveFarbeAdapter());
    Hive.registerAdapter(HiveVersandartAdapter());
    
    // Öffne die Boxen für die verschiedenen Datentypen
    await Hive.openBox<HiveLabTest>(AppConstants.testsBox);
    await Hive.openBox<HiveEinheit>(AppConstants.einheitenBox);
    await Hive.openBox<HiveMaterial>(AppConstants.materialBox);
    await Hive.openBox<HiveProfil>(AppConstants.profileBox);
    await Hive.openBox<HiveReferenzwert>(AppConstants.referenzwerteBox);
    await Hive.openBox<HiveEmpfaenger>(AppConstants.empfaengerBox);
    await Hive.openBox<HiveFarbe>(AppConstants.farbenBox);
    await Hive.openBox<HiveVersandart>(AppConstants.versandartBox);
    
    // Lade die initialen Daten, wenn die Boxen leer sind
    await _loadInitialDataIfNeeded();
  }

  /// Lädt die initialen Daten aus den JSON-Dateien, wenn die Boxen leer sind
  Future<void> _loadInitialDataIfNeeded() async {
    final testsBox = Hive.box<HiveLabTest>(AppConstants.testsBox);
    
    // Prüfe, ob die Tests-Box leer ist
    if (testsBox.isEmpty) {
      await _loadTests();
      await _loadEinheiten();
      await _loadMaterial();
      await _loadProfile();
      await _loadReferenzwerte();
      await _loadEmpfaenger();
      await _loadFarben();
      await _loadVersandart();
    }
  }

  /// Lädt die Tests aus der JSON-Datei
  Future<void> _loadTests() async {
    try {
      final box = Hive.box<HiveLabTest>(AppConstants.testsBox);
      final String jsonString = await rootBundle.loadString(AppConstants.testsJsonPath);
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      final List<dynamic> tests = jsonData['tests'];

      for (var test in tests) {
        // Formatiere die Felder material und synonyme, um geschweifte Klammern zu entfernen
        String material = test['material'] ?? '';
        String synonyme = test['synonyme'] ?? '';
        
        // Entferne geschweifte Klammern aus dem Material-Feld
        if (material.startsWith('{') && material.endsWith('}')) {
          material = material.substring(1, material.length - 1);
        }
        
        // Entferne geschweifte Klammern aus dem Synonyme-Feld
        if (synonyme.startsWith('{') && synonyme.endsWith('}')) {
          synonyme = synonyme.substring(1, synonyme.length - 1);
        }
        
        final hiveTest = HiveLabTest()
          ..id = test['id'] ?? ''
          ..name = test['name'] ?? ''
          ..kategorie = test['kategorie'] ?? ''
          ..material = material
          ..synonyme = synonyme
          ..aktiv = test['aktiv'] == true || test['aktiv'] == 1
          ..einheitId = test['einheit_id'] ?? ''
          ..befundzeit = test['befundzeit'] ?? ''
          ..durchfuehrung = test['durchfuehrung'] ?? ''
          ..loinc = test['loinc'] ?? ''
          ..mindestmengeMl = (test['mindestmenge_ml'] is int) 
              ? (test['mindestmenge_ml'] as int).toDouble() 
              : (test['mindestmenge_ml'] ?? 0.0)
          ..lagerung = test['lagerung'] ?? ''
          ..dokumente = test['dokumente'] ?? ''
          ..hinweise = test['hinweise'] ?? ''
          ..ebm = test['ebm'] ?? ''
          ..goae = test['goae'] ?? '';
        
        // Verwende die Test-ID als Schlüssel
        if (test['id'] != null) {
          await box.put(test['id'], hiveTest);
        }
      }
      print('Tests erfolgreich geladen');
    } catch (e) {
      print('Fehler beim Laden der Tests: $e');
    }
  }

  /// Lädt die Einheiten aus der JSON-Datei
  Future<void> _loadEinheiten() async {
    try {
      final box = Hive.box<HiveEinheit>(AppConstants.einheitenBox);
      final String jsonString = await rootBundle.loadString(AppConstants.einheitenJsonPath);
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      final List<dynamic> einheiten = jsonData['einheiten'];

      for (var einheit in einheiten) {
        final hiveEinheit = HiveEinheit()
          ..einheitId = einheit['einheit_id'] ?? ''
          ..siEinheit = einheit['si_einheit'] ?? ''
          ..beschreibung = einheit['beschreibung'] ?? ''
          ..bezeichnung = einheit['bezeichnung'] ?? ''
          ..einheitIdDb = einheit['einheit_id_db']?.toString() ?? '0'
          ..kategorie = einheit['kategorie'] ?? '';
        
        // Verwende die Einheit-ID als Schlüssel
        if (einheit['einheit_id'] != null) {
          await box.put(einheit['einheit_id'], hiveEinheit);
        }
      }
      print('Einheiten erfolgreich geladen');
    } catch (e) {
      print('Fehler beim Laden der Einheiten: $e');
    }
  }

  /// Lädt das Material aus der JSON-Datei
  Future<void> _loadMaterial() async {
    try {
      final box = Hive.box<HiveMaterial>(AppConstants.materialBox);
      final String jsonString = await rootBundle.loadString(AppConstants.materialJsonPath);
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      final List<dynamic> materialien = jsonData['material'];

      for (var material in materialien) {
        final hiveMaterial = HiveMaterial()
          ..id = material['id'] ?? ''
          ..name = material['name'] ?? ''
          ..beschreibung = material['beschreibung'] ?? ''
          ..farbe = material['farbe'] ?? ''
          ..code = material['code'] ?? '';
        
        // Verwende die Material-ID als Schlüssel
        if (material['id'] != null) {
          await box.put(material['id'], hiveMaterial);
        }
      }
      print('Material erfolgreich geladen');
    } catch (e) {
      print('Fehler beim Laden des Materials: $e');
    }
  }

  /// Lädt die Profile aus der JSON-Datei
  Future<void> _loadProfile() async {
    try {
      final box = Hive.box<HiveProfil>(AppConstants.profileBox);
      final String jsonString = await rootBundle.loadString(AppConstants.profileJsonPath);
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      final List<dynamic> profile = jsonData['profile'];

      for (var profil in profile) {
        final hiveProfil = HiveProfil()
          ..id = profil['id'] ?? ''
          ..name = profil['name'] ?? ''
          ..tests = profil['tests'] ?? ''
          ..beschreibung = profil['beschreibung'] ?? ''
          ..aktiv = profil['aktiv'] == true || profil['aktiv'] == 1;
        
        // Verwende die Profil-ID als Schlüssel
        if (profil['id'] != null) {
          await box.put(profil['id'], hiveProfil);
        }
      }
      print('Profile erfolgreich geladen');
    } catch (e) {
      print('Fehler beim Laden der Profile: $e');
    }
  }

  /// Lädt die Referenzwerte aus der JSON-Datei
  Future<void> _loadReferenzwerte() async {
    try {
      final box = Hive.box<HiveReferenzwert>(AppConstants.referenzwerteBox);
      final String jsonString = await rootBundle.loadString(AppConstants.referenzwerteJsonPath);
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      final List<dynamic> referenzwerte = jsonData['referenzwerte'];

      for (var referenzwert in referenzwerte) {
        try {
          // Konvertiere die Werte in die richtigen Typen
          final String id = referenzwert['id']?.toString() ?? '';
          final String testId = referenzwert['test_id']?.toString() ?? '';
          final String geschlecht = referenzwert['geschlecht']?.toString() ?? '';
          final int alterMin = referenzwert['alter_min'] is int ? referenzwert['alter_min'] : 0;
          final int alterMax = referenzwert['alter_max'] is int ? referenzwert['alter_max'] : 0;
          
          double wertMin = 0.0;
          if (referenzwert['wert_min'] is int) {
            wertMin = (referenzwert['wert_min'] as int).toDouble();
          } else if (referenzwert['wert_min'] is double) {
            wertMin = referenzwert['wert_min'];
          }
          
          double wertMax = 0.0;
          if (referenzwert['wert_max'] is int) {
            wertMax = (referenzwert['wert_max'] as int).toDouble();
          } else if (referenzwert['wert_max'] is double) {
            wertMax = referenzwert['wert_max'];
          }
          
          final String einheit = referenzwert['einheit']?.toString() ?? '';
          
          final hiveReferenzwert = HiveReferenzwert()
            ..id = id
            ..testId = testId
            ..geschlecht = geschlecht
            ..alterMin = alterMin
            ..alterMax = alterMax
            ..wertMin = wertMin
            ..wertMax = wertMax
            ..einheit = einheit;
          
          // Verwende die Referenzwert-ID als Schlüssel
          if (id.isNotEmpty) {
            await box.put(id, hiveReferenzwert);
          }
        } catch (e) {
          print('Fehler beim Verarbeiten eines Referenzwerts: $e');
          // Fahre mit dem nächsten Referenzwert fort
          continue;
        }
      }
      print('Referenzwerte erfolgreich geladen');
    } catch (e) {
      print('Fehler beim Laden der Referenzwerte: $e');
    }
  }

  /// Lädt die Empfänger aus der JSON-Datei
  Future<void> _loadEmpfaenger() async {
    try {
      final box = Hive.box<HiveEmpfaenger>(AppConstants.empfaengerBox);
      final String jsonString = await rootBundle.loadString(AppConstants.empfaengerJsonPath);
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      final List<dynamic> empfaenger = jsonData['empfaenger'];

      for (var emp in empfaenger) {
        final hiveEmpfaenger = HiveEmpfaenger()
          ..id = emp['id'] ?? ''
          ..name = emp['name'] ?? ''
          ..adresse = emp['adresse'] ?? ''
          ..telefon = emp['telefon'] ?? ''
          ..email = emp['email'] ?? '';
        
        // Verwende die Empfänger-ID als Schlüssel
        if (emp['id'] != null) {
          await box.put(emp['id'], hiveEmpfaenger);
        }
      }
      print('Empfänger erfolgreich geladen');
    } catch (e) {
      print('Fehler beim Laden der Empfänger: $e');
    }
  }

  /// Lädt die Farben aus der JSON-Datei
  Future<void> _loadFarben() async {
    try {
      final box = Hive.box<HiveFarbe>(AppConstants.farbenBox);
      final String jsonString = await rootBundle.loadString(AppConstants.farbenJsonPath);
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      final List<dynamic> farben = jsonData['farben'];

      for (var farbe in farben) {
        final hiveFarbe = HiveFarbe()
          ..id = farbe['id'] ?? ''
          ..name = farbe['name'] ?? ''
          ..code = farbe['code'] ?? ''
          ..beschreibung = farbe['beschreibung'] ?? '';
        
        // Verwende die Farben-ID als Schlüssel
        if (farbe['id'] != null) {
          await box.put(farbe['id'], hiveFarbe);
        }
      }
      print('Farben erfolgreich geladen');
    } catch (e) {
      print('Fehler beim Laden der Farben: $e');
    }
  }

  /// Lädt die Versandarten aus der JSON-Datei
  Future<void> _loadVersandart() async {
    try {
      final box = Hive.box<HiveVersandart>(AppConstants.versandartBox);
      final String jsonString = await rootBundle.loadString(AppConstants.versandartJsonPath);
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      
      // Prüfe, ob 'versandart' im JSON existiert und eine Liste ist
      if (jsonData.containsKey('versandart') && jsonData['versandart'] is List) {
        final List<dynamic> versandarten = jsonData['versandart'];
        
        for (var versandart in versandarten) {
          try {
            // Konvertiere die Werte in die richtigen Typen
            final String id = versandart['versandart_id']?.toString() ?? '';
            final String name = versandart['versandart_anz']?.toString() ?? '';
            final String beschreibung = versandart['versandart_anz']?.toString() ?? '';
            final String code = versandart['versandart_id']?.toString() ?? '';
            
            final hiveVersandart = HiveVersandart()
              ..id = id
              ..name = name
              ..beschreibung = beschreibung
              ..code = code;
            
            // Verwende die Versandart-ID als Schlüssel
            if (id.isNotEmpty) {
              await box.put(id, hiveVersandart);
            }
          } catch (e) {
            print('Fehler beim Verarbeiten einer Versandart: $e');
            // Fahre mit der nächsten Versandart fort
            continue;
          }
        }
        print('Versandarten erfolgreich geladen');
      } else {
        // Erstelle Beispiel-Versandarten, wenn keine im JSON vorhanden sind
        print('Keine Versandarten in der JSON-Datei gefunden, erstelle Beispiel-Versandarten');
        final hiveVersandart = HiveVersandart()
          ..id = '1'
          ..name = 'Standard'
          ..beschreibung = 'Standardversand'
          ..code = 'STD';
        await box.put('1', hiveVersandart);
        print('Beispiel-Versandarten erstellt');
      }
    } catch (e) {
      print('Fehler beim Laden der Versandarten: $e');
    }
  }

  /// Gibt alle Tests zurück, optional gefiltert nach Kategorie
  List<HiveLabTest> getTests({String? kategorie}) {
    final box = Hive.box<HiveLabTest>(AppConstants.testsBox);
    final tests = box.values.toList();
    
    if (kategorie != null) {
      return tests.where((test) => test.kategorie == kategorie).toList();
    }
    
    return tests;
  }

  /// Gibt einen Test anhand seiner ID zurück
  HiveLabTest? getTestById(String id) {
    final box = Hive.box<HiveLabTest>(AppConstants.testsBox);
    return box.get(id);
  }

  /// Gibt alle Einheiten zurück
  List<HiveEinheit> getEinheiten() {
    final box = Hive.box<HiveEinheit>(AppConstants.einheitenBox);
    return box.values.toList();
  }

  /// Gibt eine Einheit anhand ihrer ID zurück
  HiveEinheit? getEinheitById(String id) {
    final box = Hive.box<HiveEinheit>(AppConstants.einheitenBox);
    return box.get(id);
  }

  /// Gibt alle Referenzwerte für einen Test zurück
  List<HiveReferenzwert> getReferenzwerte(String testId) {
    final box = Hive.box<HiveReferenzwert>(AppConstants.referenzwerteBox);
    return box.values.where((referenzwert) => referenzwert.testId == testId).toList();
  }

  /// Gibt alle Materialien zurück
  List<HiveMaterial> getMaterial() {
    final box = Hive.box<HiveMaterial>(AppConstants.materialBox);
    return box.values.toList();
  }

  /// Gibt ein Material anhand seiner ID zurück
  HiveMaterial? getMaterialById(String id) {
    final box = Hive.box<HiveMaterial>(AppConstants.materialBox);
    return box.get(id);
  }

  /// Gibt alle Profile zurück
  List<HiveProfil> getProfile() {
    final box = Hive.box<HiveProfil>(AppConstants.profileBox);
    return box.values.toList();
  }

  /// Gibt ein Profil anhand seiner ID zurück
  HiveProfil? getProfilById(String id) {
    final box = Hive.box<HiveProfil>(AppConstants.profileBox);
    return box.get(id);
  }

  /// Gibt alle Empfänger zurück
  List<HiveEmpfaenger> getEmpfaenger() {
    final box = Hive.box<HiveEmpfaenger>(AppConstants.empfaengerBox);
    return box.values.toList();
  }

  /// Gibt einen Empfänger anhand seiner ID zurück
  HiveEmpfaenger? getEmpfaengerById(String id) {
    final box = Hive.box<HiveEmpfaenger>(AppConstants.empfaengerBox);
    return box.get(id);
  }

  /// Gibt alle Farben zurück
  List<HiveFarbe> getFarben() {
    final box = Hive.box<HiveFarbe>(AppConstants.farbenBox);
    return box.values.toList();
  }

  /// Gibt eine Farbe anhand ihrer ID zurück
  HiveFarbe? getFarbeById(String id) {
    final box = Hive.box<HiveFarbe>(AppConstants.farbenBox);
    return box.get(id);
  }

  /// Gibt alle Versandarten zurück
  List<HiveVersandart> getVersandarten() {
    final box = Hive.box<HiveVersandart>(AppConstants.versandartBox);
    return box.values.toList();
  }

  /// Gibt eine Versandart anhand ihrer ID zurück
  HiveVersandart? getVersandartById(String id) {
    final box = Hive.box<HiveVersandart>(AppConstants.versandartBox);
    return box.get(id);
  }

  /// Sucht nach Tests anhand eines Suchbegriffs
  List<HiveLabTest> searchTests(String query) {
    final box = Hive.box<HiveLabTest>(AppConstants.testsBox);
    final tests = box.values.toList();
    final lowercaseQuery = query.toLowerCase();
    
    return tests.where((test) {
      return test.name.toLowerCase().contains(lowercaseQuery) ||
             test.synonyme.toLowerCase().contains(lowercaseQuery) ||
             test.loinc.toLowerCase().contains(lowercaseQuery);
    }).toList();
  }
}
