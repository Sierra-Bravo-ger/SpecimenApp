import 'package:hive/hive.dart';

part 'hive_models.g.dart';

/// Hive-Modell für einen Labortest
@HiveType(typeId: 0)
class HiveLabTest extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String name;

  @HiveField(2)
  late String kategorie;

  @HiveField(3)
  late String material;

  @HiveField(4)
  late String synonyme;

  @HiveField(5)
  late bool aktiv;

  @HiveField(6)
  late String einheitId;

  @HiveField(7)
  late String befundzeit;

  @HiveField(8)
  late String durchfuehrung;

  @HiveField(9)
  late String loinc;

  @HiveField(10)
  late double mindestmengeMl;

  @HiveField(11)
  late String lagerung;

  @HiveField(12)
  late String dokumente;

  @HiveField(13)
  late String hinweise;

  @HiveField(14)
  late String ebm;

  @HiveField(15)
  late String goae;
}

/// Hive-Modell für eine Einheit
@HiveType(typeId: 1)
class HiveEinheit extends HiveObject {
  @HiveField(0)
  late String einheitId;

  @HiveField(1)
  late String siEinheit;

  @HiveField(2)
  late String beschreibung;

  @HiveField(3)
  late String bezeichnung;

  @HiveField(4)
  late String einheitIdDb;

  @HiveField(5)
  late String kategorie;
}

/// Hive-Modell für ein Material
@HiveType(typeId: 2)
class HiveMaterial extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String name;

  @HiveField(2)
  late String beschreibung;

  @HiveField(3)
  late String farbe;

  @HiveField(4)
  late String code;
}

/// Hive-Modell für ein Profil
@HiveType(typeId: 3)
class HiveProfil extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String name;

  @HiveField(2)
  late String tests;

  @HiveField(3)
  late String beschreibung;

  @HiveField(4)
  late bool aktiv;
}

/// Hive-Modell für einen Referenzwert
@HiveType(typeId: 4)
class HiveReferenzwert extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String testId;

  @HiveField(2)
  late String geschlecht;

  @HiveField(3)
  late int alterMin;

  @HiveField(4)
  late int alterMax;

  @HiveField(5)
  late double wertMin;

  @HiveField(6)
  late double wertMax;

  @HiveField(7)
  late String einheit;
}

/// Hive-Modell für einen Empfänger
@HiveType(typeId: 5)
class HiveEmpfaenger extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String name;

  @HiveField(2)
  late String adresse;

  @HiveField(3)
  late String telefon;

  @HiveField(4)
  late String email;
}

/// Hive-Modell für eine Farbe
@HiveType(typeId: 6)
class HiveFarbe extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String name;

  @HiveField(2)
  late String code;

  @HiveField(3)
  late String beschreibung;
}

/// Hive-Modell für eine Versandart
@HiveType(typeId: 7)
class HiveVersandart extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String name;

  @HiveField(2)
  late String beschreibung;

  @HiveField(3)
  late String code;
}
