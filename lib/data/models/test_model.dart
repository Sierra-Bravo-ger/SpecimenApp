import 'package:json_annotation/json_annotation.dart';

part 'test_model.g.dart';

/// Modell für einen Labortest
@JsonSerializable()
class LabTest {
  final String id;
  final String name;
  final String kategorie;
  final String material;
  final String synonyme;
  final bool aktiv;
  final String einheitId;
  final String befundzeit;
  final String durchfuehrung;
  final String loinc;
  final double mindestmengeMl;
  final String lagerung;
  final String dokumente;
  final String hinweise;
  final String ebm;
  final String goae;

  LabTest({
    required this.id,
    required this.name,
    required this.kategorie,
    required this.material,
    required this.synonyme,
    required this.aktiv,
    required this.einheitId,
    required this.befundzeit,
    required this.durchfuehrung,
    required this.loinc,
    required this.mindestmengeMl,
    required this.lagerung,
    required this.dokumente,
    required this.hinweise,
    required this.ebm,
    required this.goae,
  });

  /// Erstellt ein LabTest-Objekt aus einem JSON-Objekt
  factory LabTest.fromJson(Map<String, dynamic> json) => _$LabTestFromJson(json);

  /// Konvertiert das LabTest-Objekt in ein JSON-Objekt
  Map<String, dynamic> toJson() => _$LabTestToJson(this);

  /// Erstellt ein LabTest-Objekt aus einem Map (für Datenbank-Operationen)
  factory LabTest.fromMap(Map<dynamic, dynamic> map) {
    return LabTest(
      id: map['id'] as String,
      name: map['name'] as String,
      kategorie: map['kategorie'] as String,
      material: map['material'] as String,
      synonyme: map['synonyme'] as String,
      aktiv: map['aktiv'] is int ? (map['aktiv'] as int) == 1 : map['aktiv'] as bool,
      einheitId: map['einheit_id'] as String,
      befundzeit: map['befundzeit'] as String,
      durchfuehrung: map['durchfuehrung'] as String,
      loinc: map['loinc'] as String,
      mindestmengeMl: map['mindestmenge_ml'] is int 
          ? (map['mindestmenge_ml'] as int).toDouble() 
          : map['mindestmenge_ml'] as double,
      lagerung: map['lagerung'] as String,
      dokumente: map['dokumente'] as String,
      hinweise: map['hinweise'] as String,
      ebm: map['ebm'] as String,
      goae: map['goae'] as String,
    );
  }

  /// Konvertiert das LabTest-Objekt in ein Map (für Datenbank-Operationen)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'kategorie': kategorie,
      'material': material,
      'synonyme': synonyme,
      'aktiv': aktiv ? 1 : 0,
      'einheit_id': einheitId,
      'befundzeit': befundzeit,
      'durchfuehrung': durchfuehrung,
      'loinc': loinc,
      'mindestmenge_ml': mindestmengeMl,
      'lagerung': lagerung,
      'dokumente': dokumente,
      'hinweise': hinweise,
      'ebm': ebm,
      'goae': goae,
    };
  }
}
