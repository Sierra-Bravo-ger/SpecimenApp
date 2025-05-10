// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LabTest _$LabTestFromJson(Map<String, dynamic> json) => LabTest(
      id: json['id'] as String,
      name: json['name'] as String,
      kategorie: json['kategorie'] as String,
      material: json['material'] as String,
      synonyme: json['synonyme'] as String,
      aktiv: json['aktiv'] as bool,
      einheitId: json['einheitId'] as String,
      befundzeit: json['befundzeit'] as String,
      durchfuehrung: json['durchfuehrung'] as String,
      loinc: json['loinc'] as String,
      mindestmengeMl: (json['mindestmengeMl'] as num).toDouble(),
      lagerung: json['lagerung'] as String,
      dokumente: json['dokumente'] as String,
      hinweise: json['hinweise'] as String,
      ebm: json['ebm'] as String,
      goae: json['goae'] as String,
    );

Map<String, dynamic> _$LabTestToJson(LabTest instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'kategorie': instance.kategorie,
      'material': instance.material,
      'synonyme': instance.synonyme,
      'aktiv': instance.aktiv,
      'einheitId': instance.einheitId,
      'befundzeit': instance.befundzeit,
      'durchfuehrung': instance.durchfuehrung,
      'loinc': instance.loinc,
      'mindestmengeMl': instance.mindestmengeMl,
      'lagerung': instance.lagerung,
      'dokumente': instance.dokumente,
      'hinweise': instance.hinweise,
      'ebm': instance.ebm,
      'goae': instance.goae,
    };
