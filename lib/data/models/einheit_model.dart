import 'package:json_annotation/json_annotation.dart';

part 'einheit_model.g.dart';

/// Modell für eine Einheit
@JsonSerializable()
class Einheit {
  final String einheitId;
  final String? siEinheit;
  final String beschreibung;
  final String bezeichnung;
  final int einheitIdDb;
  final String kategorie;

  Einheit({
    required this.einheitId,
    this.siEinheit,
    required this.beschreibung,
    required this.bezeichnung,
    required this.einheitIdDb,
    required this.kategorie,
  });

  /// Erstellt ein Einheit-Objekt aus einem JSON-Objekt
  factory Einheit.fromJson(Map<String, dynamic> json) => _$EinheitFromJson(json);

  /// Konvertiert das Einheit-Objekt in ein JSON-Objekt
  Map<String, dynamic> toJson() => _$EinheitToJson(this);

  /// Erstellt ein Einheit-Objekt aus einem Map (für Datenbank-Operationen)
  factory Einheit.fromMap(Map<dynamic, dynamic> map) {
    return Einheit(
      einheitId: map['einheit_id'] as String,
      siEinheit: map['si_einheit'] as String?,
      beschreibung: map['beschreibung'] as String,
      bezeichnung: map['bezeichnung'] as String,
      einheitIdDb: map['einheit_id_db'] as int,
      kategorie: map['kategorie'] as String,
    );
  }

  /// Konvertiert das Einheit-Objekt in ein Map (für Datenbank-Operationen)
  Map<String, dynamic> toMap() {
    return {
      'einheit_id': einheitId,
      'si_einheit': siEinheit,
      'beschreibung': beschreibung,
      'bezeichnung': bezeichnung,
      'einheit_id_db': einheitIdDb,
      'kategorie': kategorie,
    };
  }
}
