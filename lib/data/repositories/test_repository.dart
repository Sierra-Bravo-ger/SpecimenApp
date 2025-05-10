import 'package:specimen_one/core/database/database_helper.dart';
import 'package:specimen_one/core/database/hive_helper.dart';
import 'package:specimen_one/data/models/test_model.dart';
import 'package:specimen_one/data/models/einheit_model.dart';
import 'package:specimen_one/data/models/referenzwert_model.dart';
import 'package:specimen_one/data/models/hive_models.dart';

/// Repository für Tests und zugehörige Daten
/// Dient als Vermittler zwischen Datenquellen und UI
class TestRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  final HiveHelper _hiveHelper = HiveHelper();
  
  // Flag, um zu bestimmen, welche Datenbank verwendet werden soll
  final bool _useHive = true; // Standardmäßig Hive verwenden
  
  /// Gibt alle Tests zurück, optional gefiltert nach Kategorie
  Future<List<LabTest>> getTests({String? kategorie}) async {
    if (_useHive) {
      final tests = _hiveHelper.getTests(kategorie: kategorie);
      return tests.map((test) => _convertHiveLabTestToLabTest(test)).toList();
    } else {
      final testMaps = await _dbHelper.getTests(kategorie: kategorie);
      return testMaps.map((test) => LabTest.fromMap(test)).toList();
    }
  }
  
  /// Gibt einen Test anhand seiner ID zurück
  Future<LabTest?> getTestById(String id) async {
    if (_useHive) {
      final test = _hiveHelper.getTestById(id);
      return test != null ? _convertHiveLabTestToLabTest(test) : null;
    } else {
      final testMap = await _dbHelper.getTestById(id);
      return testMap != null ? LabTest.fromMap(testMap) : null;
    }
  }
  
  /// Gibt alle Einheiten zurück
  Future<List<Einheit>> getEinheiten() async {
    if (_useHive) {
      final einheiten = _hiveHelper.getEinheiten();
      return einheiten.map((einheit) => _convertHiveEinheitToEinheit(einheit)).toList();
    } else {
      final einheitMaps = await _dbHelper.getEinheiten();
      return einheitMaps.map((einheit) => Einheit.fromMap(einheit)).toList();
    }
  }
  
  /// Gibt eine Einheit anhand ihrer ID zurück
  Future<Einheit?> getEinheitById(String id) async {
    if (_useHive) {
      final einheit = _hiveHelper.getEinheitById(id);
      return einheit != null ? _convertHiveEinheitToEinheit(einheit) : null;
    } else {
      final einheitMap = await _dbHelper.getEinheitById(id);
      return einheitMap != null ? Einheit.fromMap(einheitMap) : null;
    }
  }
  
  /// Gibt alle Referenzwerte für einen Test zurück
  Future<List<Referenzwert>> getReferenzwerteForTest(String testId) async {
    if (_useHive) {
      final referenzwerte = _hiveHelper.getReferenzwerte(testId);
      return referenzwerte.map((referenzwert) => _convertHiveReferenzwertToReferenzwert(referenzwert)).toList();
    } else {
      final referenzwertMaps = await _dbHelper.getReferenzwerte(testId);
      return referenzwertMaps.map((referenzwert) => Referenzwert.fromMap(referenzwert)).toList();
    }
  }
  
  /// Sucht nach Tests anhand eines Suchbegriffs
  Future<List<LabTest>> searchTests(String query) async {
    if (_useHive) {
      final tests = _hiveHelper.searchTests(query);
      return tests.map((test) => _convertHiveLabTestToLabTest(test)).toList();
    } else {
      final testMaps = await _dbHelper.searchTests(query);
      return testMaps.map((test) => LabTest.fromMap(test)).toList();
    }
  }
  
  /// Konvertiert ein HiveLabTest-Objekt in ein LabTest-Objekt
  LabTest _convertHiveLabTestToLabTest(HiveLabTest hiveTest) {
    return LabTest(
      id: hiveTest.id,
      name: hiveTest.name,
      kategorie: hiveTest.kategorie,
      material: hiveTest.material,
      synonyme: hiveTest.synonyme,
      aktiv: hiveTest.aktiv,
      einheitId: hiveTest.einheitId,
      befundzeit: hiveTest.befundzeit,
      durchfuehrung: hiveTest.durchfuehrung,
      loinc: hiveTest.loinc,
      mindestmengeMl: hiveTest.mindestmengeMl,
      lagerung: hiveTest.lagerung,
      dokumente: hiveTest.dokumente,
      hinweise: hiveTest.hinweise,
      ebm: hiveTest.ebm,
      goae: hiveTest.goae,
    );
  }
  
  /// Konvertiert ein HiveEinheit-Objekt in ein Einheit-Objekt
  Einheit _convertHiveEinheitToEinheit(HiveEinheit hiveEinheit) {
    return Einheit(
      einheitId: hiveEinheit.einheitId,
      siEinheit: hiveEinheit.siEinheit,
      beschreibung: hiveEinheit.beschreibung,
      bezeichnung: hiveEinheit.bezeichnung,
      einheitIdDb: int.parse(hiveEinheit.einheitIdDb),
      kategorie: hiveEinheit.kategorie,
    );
  }
  
  /// Konvertiert ein HiveReferenzwert-Objekt in ein Referenzwert-Objekt
  Referenzwert _convertHiveReferenzwertToReferenzwert(HiveReferenzwert hiveReferenzwert) {
    return Referenzwert(
      id: hiveReferenzwert.id,
      testId: hiveReferenzwert.testId,
      geschlecht: hiveReferenzwert.geschlecht,
      alterMin: hiveReferenzwert.alterMin,
      alterMax: hiveReferenzwert.alterMax,
      wertMin: hiveReferenzwert.wertMin,
      wertMax: hiveReferenzwert.wertMax,
      einheit: hiveReferenzwert.einheit,
    );
  }
  
  /// Gibt alle Tests für eine Liste von Test-IDs zurück
  Future<List<LabTest>> getTestsByIds(List<String> testIds) async {
    final List<LabTest> tests = [];
    
    for (final id in testIds) {
      final test = await getTestById(id);
      if (test != null) {
        tests.add(test);
      }
    }
    
    return tests;
  }
  
  /// Gibt alle aktiven Tests zurück
  Future<List<LabTest>> getActiveTests({String? kategorie}) async {
    final tests = await getTests(kategorie: kategorie);
    return tests.where((test) => test.aktiv).toList();
  }
  
  /// Gibt die Anzahl der Tests pro Kategorie zurück
  Future<Map<String, int>> getTestCountByCategory() async {
    final Map<String, int> counts = {};
    final tests = await getTests();
    
    for (final test in tests) {
      if (counts.containsKey(test.kategorie)) {
        counts[test.kategorie] = counts[test.kategorie]! + 1;
      } else {
        counts[test.kategorie] = 1;
      }
    }
    
    return counts;
  }
}
