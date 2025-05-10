// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_models.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveLabTestAdapter extends TypeAdapter<HiveLabTest> {
  @override
  final int typeId = 0;

  @override
  HiveLabTest read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveLabTest()
      ..id = fields[0] as String
      ..name = fields[1] as String
      ..kategorie = fields[2] as String
      ..material = fields[3] as String
      ..synonyme = fields[4] as String
      ..aktiv = fields[5] as bool
      ..einheitId = fields[6] as String
      ..befundzeit = fields[7] as String
      ..durchfuehrung = fields[8] as String
      ..loinc = fields[9] as String
      ..mindestmengeMl = fields[10] as double
      ..lagerung = fields[11] as String
      ..dokumente = fields[12] as String
      ..hinweise = fields[13] as String
      ..ebm = fields[14] as String
      ..goae = fields[15] as String;
  }

  @override
  void write(BinaryWriter writer, HiveLabTest obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.kategorie)
      ..writeByte(3)
      ..write(obj.material)
      ..writeByte(4)
      ..write(obj.synonyme)
      ..writeByte(5)
      ..write(obj.aktiv)
      ..writeByte(6)
      ..write(obj.einheitId)
      ..writeByte(7)
      ..write(obj.befundzeit)
      ..writeByte(8)
      ..write(obj.durchfuehrung)
      ..writeByte(9)
      ..write(obj.loinc)
      ..writeByte(10)
      ..write(obj.mindestmengeMl)
      ..writeByte(11)
      ..write(obj.lagerung)
      ..writeByte(12)
      ..write(obj.dokumente)
      ..writeByte(13)
      ..write(obj.hinweise)
      ..writeByte(14)
      ..write(obj.ebm)
      ..writeByte(15)
      ..write(obj.goae);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveLabTestAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class HiveEinheitAdapter extends TypeAdapter<HiveEinheit> {
  @override
  final int typeId = 1;

  @override
  HiveEinheit read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveEinheit()
      ..einheitId = fields[0] as String
      ..siEinheit = fields[1] as String
      ..beschreibung = fields[2] as String
      ..bezeichnung = fields[3] as String
      ..einheitIdDb = fields[4] as String
      ..kategorie = fields[5] as String;
  }

  @override
  void write(BinaryWriter writer, HiveEinheit obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.einheitId)
      ..writeByte(1)
      ..write(obj.siEinheit)
      ..writeByte(2)
      ..write(obj.beschreibung)
      ..writeByte(3)
      ..write(obj.bezeichnung)
      ..writeByte(4)
      ..write(obj.einheitIdDb)
      ..writeByte(5)
      ..write(obj.kategorie);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveEinheitAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class HiveMaterialAdapter extends TypeAdapter<HiveMaterial> {
  @override
  final int typeId = 2;

  @override
  HiveMaterial read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveMaterial()
      ..id = fields[0] as String
      ..name = fields[1] as String
      ..beschreibung = fields[2] as String
      ..farbe = fields[3] as String
      ..code = fields[4] as String;
  }

  @override
  void write(BinaryWriter writer, HiveMaterial obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.beschreibung)
      ..writeByte(3)
      ..write(obj.farbe)
      ..writeByte(4)
      ..write(obj.code);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveMaterialAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class HiveProfilAdapter extends TypeAdapter<HiveProfil> {
  @override
  final int typeId = 3;

  @override
  HiveProfil read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveProfil()
      ..id = fields[0] as String
      ..name = fields[1] as String
      ..tests = fields[2] as String
      ..beschreibung = fields[3] as String
      ..aktiv = fields[4] as bool;
  }

  @override
  void write(BinaryWriter writer, HiveProfil obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.tests)
      ..writeByte(3)
      ..write(obj.beschreibung)
      ..writeByte(4)
      ..write(obj.aktiv);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveProfilAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class HiveReferenzwertAdapter extends TypeAdapter<HiveReferenzwert> {
  @override
  final int typeId = 4;

  @override
  HiveReferenzwert read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveReferenzwert()
      ..id = fields[0] as String
      ..testId = fields[1] as String
      ..geschlecht = fields[2] as String
      ..alterMin = fields[3] as int
      ..alterMax = fields[4] as int
      ..wertMin = fields[5] as double
      ..wertMax = fields[6] as double
      ..einheit = fields[7] as String;
  }

  @override
  void write(BinaryWriter writer, HiveReferenzwert obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.testId)
      ..writeByte(2)
      ..write(obj.geschlecht)
      ..writeByte(3)
      ..write(obj.alterMin)
      ..writeByte(4)
      ..write(obj.alterMax)
      ..writeByte(5)
      ..write(obj.wertMin)
      ..writeByte(6)
      ..write(obj.wertMax)
      ..writeByte(7)
      ..write(obj.einheit);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveReferenzwertAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class HiveEmpfaengerAdapter extends TypeAdapter<HiveEmpfaenger> {
  @override
  final int typeId = 5;

  @override
  HiveEmpfaenger read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveEmpfaenger()
      ..id = fields[0] as String
      ..name = fields[1] as String
      ..adresse = fields[2] as String
      ..telefon = fields[3] as String
      ..email = fields[4] as String;
  }

  @override
  void write(BinaryWriter writer, HiveEmpfaenger obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.adresse)
      ..writeByte(3)
      ..write(obj.telefon)
      ..writeByte(4)
      ..write(obj.email);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveEmpfaengerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class HiveFarbeAdapter extends TypeAdapter<HiveFarbe> {
  @override
  final int typeId = 6;

  @override
  HiveFarbe read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveFarbe()
      ..id = fields[0] as String
      ..name = fields[1] as String
      ..code = fields[2] as String
      ..beschreibung = fields[3] as String;
  }

  @override
  void write(BinaryWriter writer, HiveFarbe obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.code)
      ..writeByte(3)
      ..write(obj.beschreibung);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveFarbeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class HiveVersandartAdapter extends TypeAdapter<HiveVersandart> {
  @override
  final int typeId = 7;

  @override
  HiveVersandart read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveVersandart()
      ..id = fields[0] as String
      ..name = fields[1] as String
      ..beschreibung = fields[2] as String
      ..code = fields[3] as String;
  }

  @override
  void write(BinaryWriter writer, HiveVersandart obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.beschreibung)
      ..writeByte(3)
      ..write(obj.code);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveVersandartAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
