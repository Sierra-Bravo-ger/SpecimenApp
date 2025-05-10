// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'material_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Material _$MaterialFromJson(Map<String, dynamic> json) => Material(
      id: json['id'] as String,
      name: json['name'] as String,
      beschreibung: json['beschreibung'] as String,
      farbe: json['farbe'] as String,
      code: json['code'] as String,
    );

Map<String, dynamic> _$MaterialToJson(Material instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'beschreibung': instance.beschreibung,
      'farbe': instance.farbe,
      'code': instance.code,
    };
