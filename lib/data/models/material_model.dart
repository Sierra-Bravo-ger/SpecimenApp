import 'package:json_annotation/json_annotation.dart';

part 'material_model.g.dart';

/// Modell für ein Material
@JsonSerializable()
class Material {
  final String id;
  final String name;
  final String beschreibung;
  final String farbe;
  final String code;

  Material({
    required this.id,
    required this.name,
    required this.beschreibung,
    required this.farbe,
    required this.code,
  });

  /// Erstellt ein Material-Objekt aus einem JSON-Objekt
  factory Material.fromJson(Map<String, dynamic> json) => _$MaterialFromJson(json);

  /// Konvertiert das Material-Objekt in ein JSON-Objekt
  Map<String, dynamic> toJson() => _$MaterialToJson(this);

  /// Erstellt ein Material-Objekt aus einem Map (für Datenbank-Operationen)
  factory Material.fromMap(Map<dynamic, dynamic> map) {
    return Material(
      id: map['id'] as String,
      name: map['name'] as String,
      beschreibung: map['beschreibung'] as String,
      farbe: map['farbe'] as String,
      code: map['code'] as String,
    );
  }

  /// Konvertiert das Material-Objekt in ein Map (für Datenbank-Operationen)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'beschreibung': beschreibung,
      'farbe': farbe,
      'code': code,
    };
  }
}
