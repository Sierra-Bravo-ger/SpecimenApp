import 'package:json_annotation/json_annotation.dart';

part 'referenzwert_model.g.dart';

/// Modell für einen Referenzwert
@JsonSerializable()
class Referenzwert {
  final String id;
  final String testId;
  final String geschlecht;
  final int alterMin;
  final int alterMax;
  final double wertMin;
  final double wertMax;
  final String einheit;

  Referenzwert({
    required this.id,
    required this.testId,
    required this.geschlecht,
    required this.alterMin,
    required this.alterMax,
    required this.wertMin,
    required this.wertMax,
    required this.einheit,
  });

  /// Erstellt ein Referenzwert-Objekt aus einem JSON-Objekt
  factory Referenzwert.fromJson(Map<String, dynamic> json) => _$ReferenzwertFromJson(json);

  /// Konvertiert das Referenzwert-Objekt in ein JSON-Objekt
  Map<String, dynamic> toJson() => _$ReferenzwertToJson(this);

  /// Erstellt ein Referenzwert-Objekt aus einem Map (für Datenbank-Operationen)
  factory Referenzwert.fromMap(Map<dynamic, dynamic> map) {
    return Referenzwert(
      id: map['id'] as String,
      testId: map['test_id'] as String,
      geschlecht: map['geschlecht'] as String,
      alterMin: map['alter_min'] as int,
      alterMax: map['alter_max'] as int,
      wertMin: map['wert_min'] is int 
          ? (map['wert_min'] as int).toDouble() 
          : map['wert_min'] as double,
      wertMax: map['wert_max'] is int 
          ? (map['wert_max'] as int).toDouble() 
          : map['wert_max'] as double,
      einheit: map['einheit'] as String,
    );
  }

  /// Konvertiert das Referenzwert-Objekt in ein Map (für Datenbank-Operationen)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'test_id': testId,
      'geschlecht': geschlecht,
      'alter_min': alterMin,
      'alter_max': alterMax,
      'wert_min': wertMin,
      'wert_max': wertMax,
      'einheit': einheit,
    };
  }

  /// Prüft, ob ein Wert innerhalb des Referenzbereichs liegt
  bool isWertInRange(double wert) {
    return wert >= wertMin && wert <= wertMax;
  }

  /// Prüft, ob ein Alter innerhalb des Referenzbereichs liegt
  bool isAlterInRange(int alter) {
    return alter >= alterMin && alter <= alterMax;
  }

  /// Prüft, ob ein Geschlecht dem Referenzbereich entspricht
  bool isGeschlechtMatch(String patientenGeschlecht) {
    if (geschlecht == 'alle') {
      return true;
    }
    return geschlecht.toLowerCase() == patientenGeschlecht.toLowerCase();
  }
}
