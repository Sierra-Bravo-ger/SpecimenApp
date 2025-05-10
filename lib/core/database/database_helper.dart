import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:specimen_one/core/constants/app_constants.dart';

/// DatabaseHelper verwaltet die SQLite-Datenbank für die Offline-Funktionalität
class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, AppConstants.databaseName);
    return await openDatabase(
      path,
      version: AppConstants.databaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // Tabelle für Tests
    await db.execute('''
      CREATE TABLE tests (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        kategorie TEXT,
        material TEXT,
        synonyme TEXT,
        aktiv INTEGER,
        einheit_id TEXT,
        befundzeit TEXT,
        durchfuehrung TEXT,
        loinc TEXT,
        mindestmenge_ml REAL,
        lagerung TEXT,
        dokumente TEXT,
        hinweise TEXT,
        ebm TEXT,
        goae TEXT
      )
    ''');

    // Tabelle für Einheiten
    await db.execute('''
      CREATE TABLE einheiten (
        einheit_id TEXT PRIMARY KEY,
        si_einheit TEXT,
        beschreibung TEXT,
        bezeichnung TEXT,
        einheit_id_db INTEGER,
        kategorie TEXT
      )
    ''');

    // Tabelle für Material
    await db.execute('''
      CREATE TABLE material (
        id TEXT PRIMARY KEY,
        name TEXT,
        beschreibung TEXT,
        farbe TEXT,
        code TEXT
      )
    ''');

    // Tabelle für Profile
    await db.execute('''
      CREATE TABLE profile (
        id TEXT PRIMARY KEY,
        name TEXT,
        tests TEXT,
        beschreibung TEXT,
        aktiv INTEGER
      )
    ''');

    // Tabelle für Referenzwerte
    await db.execute('''
      CREATE TABLE referenzwerte (
        id TEXT PRIMARY KEY,
        test_id TEXT,
        geschlecht TEXT,
        alter_min INTEGER,
        alter_max INTEGER,
        wert_min REAL,
        wert_max REAL,
        einheit TEXT
      )
    ''');

    // Tabelle für Empfänger
    await db.execute('''
      CREATE TABLE empfaenger (
        id TEXT PRIMARY KEY,
        name TEXT,
        adresse TEXT,
        telefon TEXT,
        email TEXT
      )
    ''');

    // Tabelle für Farben
    await db.execute('''
      CREATE TABLE farben (
        id TEXT PRIMARY KEY,
        name TEXT,
        hex_code TEXT,
        rgb_code TEXT
      )
    ''');

    // Tabelle für Versandarten
    await db.execute('''
      CREATE TABLE versandart (
        id TEXT PRIMARY KEY,
        name TEXT,
        beschreibung TEXT,
        code TEXT
      )
    ''');

    // Initialisiere die Datenbank mit Daten aus den JSON-Dateien
    await _loadInitialData();
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Hier können später Datenbankmigrationen implementiert werden
    if (oldVersion < 2) {
      // Beispiel für zukünftige Migrationen
    }
  }

  Future<void> _loadInitialData() async {
    await _loadTests();
    await _loadEinheiten();
    await _loadMaterial();
    await _loadProfile();
    await _loadReferenzwerte();
    await _loadEmpfaenger();
    await _loadFarben();
    await _loadVersandart();
  }

  Future<void> _loadTests() async {
    final db = await database;
    final String jsonString = await rootBundle.loadString(AppConstants.testsJsonPath);
    final Map<String, dynamic> jsonData = json.decode(jsonString);
    final List<dynamic> tests = jsonData['tests'];

    final batch = db.batch();
    for (var test in tests) {
      batch.insert('tests', {
        'id': test['id'],
        'name': test['name'],
        'kategorie': test['kategorie'],
        'material': test['material'],
        'synonyme': test['synonyme'],
        'aktiv': test['aktiv'] ? 1 : 0,
        'einheit_id': test['einheit_id'],
        'befundzeit': test['befundzeit'],
        'durchfuehrung': test['durchfuehrung'],
        'loinc': test['loinc'],
        'mindestmenge_ml': test['mindestmenge_ml'],
        'lagerung': test['lagerung'],
        'dokumente': test['dokumente'],
        'hinweise': test['hinweise'],
        'ebm': test['ebm'],
        'goae': test['goae'],
      });
    }
    await batch.commit(noResult: true);
  }

  Future<void> _loadEinheiten() async {
    final db = await database;
    final String jsonString = await rootBundle.loadString(AppConstants.einheitenJsonPath);
    final Map<String, dynamic> jsonData = json.decode(jsonString);
    final List<dynamic> einheiten = jsonData['einheiten'];

    final batch = db.batch();
    for (var einheit in einheiten) {
      batch.insert('einheiten', {
        'einheit_id': einheit['einheit_id'],
        'si_einheit': einheit['si_einheit'],
        'beschreibung': einheit['beschreibung'],
        'bezeichnung': einheit['bezeichnung'],
        'einheit_id_db': einheit['einheit_id_db'],
        'kategorie': einheit['kategorie'],
      });
    }
    await batch.commit(noResult: true);
  }

  Future<void> _loadMaterial() async {
    final db = await database;
    final String jsonString = await rootBundle.loadString(AppConstants.materialJsonPath);
    final Map<String, dynamic> jsonData = json.decode(jsonString);
    final List<dynamic> materialien = jsonData['material'];

    final batch = db.batch();
    for (var material in materialien) {
      batch.insert('material', {
        'id': material['id'],
        'name': material['name'],
        'beschreibung': material['beschreibung'],
        'farbe': material['farbe'],
        'code': material['code'],
      });
    }
    await batch.commit(noResult: true);
  }

  Future<void> _loadProfile() async {
    final db = await database;
    final String jsonString = await rootBundle.loadString(AppConstants.profileJsonPath);
    final Map<String, dynamic> jsonData = json.decode(jsonString);
    final List<dynamic> profile = jsonData['profile'];

    final batch = db.batch();
    for (var profil in profile) {
      batch.insert('profile', {
        'id': profil['id'],
        'name': profil['name'],
        'tests': profil['tests'],
        'beschreibung': profil['beschreibung'],
        'aktiv': profil['aktiv'] ? 1 : 0,
      });
    }
    await batch.commit(noResult: true);
  }

  Future<void> _loadReferenzwerte() async {
    final db = await database;
    final String jsonString = await rootBundle.loadString(AppConstants.referenzwerteJsonPath);
    final Map<String, dynamic> jsonData = json.decode(jsonString);
    final List<dynamic> referenzwerte = jsonData['referenzwerte'];

    final batch = db.batch();
    for (var referenzwert in referenzwerte) {
      batch.insert('referenzwerte', {
        'id': referenzwert['id'],
        'test_id': referenzwert['test_id'],
        'geschlecht': referenzwert['geschlecht'],
        'alter_min': referenzwert['alter_min'],
        'alter_max': referenzwert['alter_max'],
        'wert_min': referenzwert['wert_min'],
        'wert_max': referenzwert['wert_max'],
        'einheit': referenzwert['einheit'],
      });
    }
    await batch.commit(noResult: true);
  }

  Future<void> _loadEmpfaenger() async {
    final db = await database;
    final String jsonString = await rootBundle.loadString(AppConstants.empfaengerJsonPath);
    final Map<String, dynamic> jsonData = json.decode(jsonString);
    final List<dynamic> empfaenger = jsonData['empfaenger'];

    final batch = db.batch();
    for (var emp in empfaenger) {
      batch.insert('empfaenger', {
        'id': emp['id'],
        'name': emp['name'],
        'adresse': emp['adresse'],
        'telefon': emp['telefon'],
        'email': emp['email'],
      });
    }
    await batch.commit(noResult: true);
  }

  Future<void> _loadFarben() async {
    final db = await database;
    final String jsonString = await rootBundle.loadString(AppConstants.farbenJsonPath);
    final Map<String, dynamic> jsonData = json.decode(jsonString);
    final List<dynamic> farben = jsonData['farben'];

    final batch = db.batch();
    for (var farbe in farben) {
      batch.insert('farben', {
        'id': farbe['id'],
        'name': farbe['name'],
        'hex_code': farbe['hex_code'],
        'rgb_code': farbe['rgb_code'],
      });
    }
    await batch.commit(noResult: true);
  }

  Future<void> _loadVersandart() async {
    final db = await database;
    final String jsonString = await rootBundle.loadString(AppConstants.versandartJsonPath);
    final Map<String, dynamic> jsonData = json.decode(jsonString);
    final List<dynamic> versandarten = jsonData['versandart'];

    final batch = db.batch();
    for (var versandart in versandarten) {
      batch.insert('versandart', {
        'id': versandart['id'],
        'name': versandart['name'],
        'beschreibung': versandart['beschreibung'],
        'code': versandart['code'],
      });
    }
    await batch.commit(noResult: true);
  }

  // Hilfsmethoden für CRUD-Operationen

  Future<List<Map<String, dynamic>>> getTests({String? kategorie}) async {
    final db = await database;
    if (kategorie != null) {
      return await db.query('tests', where: 'kategorie = ?', whereArgs: [kategorie]);
    }
    return await db.query('tests');
  }

  Future<Map<String, dynamic>?> getTestById(String id) async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db.query(
      'tests',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    return results.isNotEmpty ? results.first : null;
  }

  Future<List<Map<String, dynamic>>> getEinheiten() async {
    final db = await database;
    return await db.query('einheiten');
  }

  Future<Map<String, dynamic>?> getEinheitById(String id) async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db.query(
      'einheiten',
      where: 'einheit_id = ?',
      whereArgs: [id],
      limit: 1,
    );
    return results.isNotEmpty ? results.first : null;
  }

  Future<List<Map<String, dynamic>>> getMaterial() async {
    final db = await database;
    return await db.query('material');
  }

  Future<List<Map<String, dynamic>>> getProfile() async {
    final db = await database;
    return await db.query('profile');
  }

  Future<List<Map<String, dynamic>>> getReferenzwerte(String testId) async {
    final db = await database;
    return await db.query(
      'referenzwerte',
      where: 'test_id = ?',
      whereArgs: [testId],
    );
  }

  // Suchfunktion für Tests
  Future<List<Map<String, dynamic>>> searchTests(String query) async {
    final db = await database;
    return await db.rawQuery('''
      SELECT * FROM tests 
      WHERE name LIKE ? OR synonyme LIKE ? OR id LIKE ?
    ''', ['%$query%', '%$query%', '%$query%']);
  }
}
