// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profil_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profil _$ProfilFromJson(Map<String, dynamic> json) => Profil(
      id: json['id'] as String,
      name: json['name'] as String,
      tests: json['tests'] as String,
      beschreibung: json['beschreibung'] as String,
      aktiv: json['aktiv'] as bool,
    );

Map<String, dynamic> _$ProfilToJson(Profil instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'tests': instance.tests,
      'beschreibung': instance.beschreibung,
      'aktiv': instance.aktiv,
    };
