// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'einheit_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Einheit _$EinheitFromJson(Map<String, dynamic> json) => Einheit(
      einheitId: json['einheitId'] as String,
      siEinheit: json['siEinheit'] as String?,
      beschreibung: json['beschreibung'] as String,
      bezeichnung: json['bezeichnung'] as String,
      einheitIdDb: (json['einheitIdDb'] as num).toInt(),
      kategorie: json['kategorie'] as String,
    );

Map<String, dynamic> _$EinheitToJson(Einheit instance) => <String, dynamic>{
      'einheitId': instance.einheitId,
      'siEinheit': instance.siEinheit,
      'beschreibung': instance.beschreibung,
      'bezeichnung': instance.bezeichnung,
      'einheitIdDb': instance.einheitIdDb,
      'kategorie': instance.kategorie,
    };
