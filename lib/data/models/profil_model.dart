import 'package:json_annotation/json_annotation.dart';

part 'profil_model.g.dart';

/// Modell für ein Profil
@JsonSerializable()
class Profil {
  final String id;
  final String name;
  final String tests;
  final String beschreibung;
  final bool aktiv;

  Profil({
    required this.id,
    required this.name,
    required this.tests,
    required this.beschreibung,
    required this.aktiv,
  });

  /// Erstellt ein Profil-Objekt aus einem JSON-Objekt
  factory Profil.fromJson(Map<String, dynamic> json) => _$ProfilFromJson(json);

  /// Konvertiert das Profil-Objekt in ein JSON-Objekt
  Map<String, dynamic> toJson() => _$ProfilToJson(this);

  /// Erstellt ein Profil-Objekt aus einem Map (für Datenbank-Operationen)
  factory Profil.fromMap(Map<dynamic, dynamic> map) {
    return Profil(
      id: map['id'] as String,
      name: map['name'] as String,
      tests: map['tests'] as String,
      beschreibung: map['beschreibung'] as String,
      aktiv: map['aktiv'] is int ? (map['aktiv'] as int) == 1 : map['aktiv'] as bool,
    );
  }

  /// Konvertiert das Profil-Objekt in ein Map (für Datenbank-Operationen)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'tests': tests,
      'beschreibung': beschreibung,
      'aktiv': aktiv ? 1 : 0,
    };
  }

  /// Gibt eine Liste der Test-IDs zurück, die in diesem Profil enthalten sind
  List<String> getTestIds() {
    // Annahme: Die Tests sind im Format "{T0001,T0002,T0003}" gespeichert
    if (tests.isEmpty || tests == '{}') {
      return [];
    }
    
    // Entferne die geschweiften Klammern und teile die Tests auf
    final String testsString = tests.substring(1, tests.length - 1);
    return testsString.split(',');
  }
}
