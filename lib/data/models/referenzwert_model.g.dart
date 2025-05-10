// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'referenzwert_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Referenzwert _$ReferenzwertFromJson(Map<String, dynamic> json) => Referenzwert(
      id: json['id'] as String,
      testId: json['testId'] as String,
      geschlecht: json['geschlecht'] as String,
      alterMin: (json['alterMin'] as num).toInt(),
      alterMax: (json['alterMax'] as num).toInt(),
      wertMin: (json['wertMin'] as num).toDouble(),
      wertMax: (json['wertMax'] as num).toDouble(),
      einheit: json['einheit'] as String,
    );

Map<String, dynamic> _$ReferenzwertToJson(Referenzwert instance) =>
    <String, dynamic>{
      'id': instance.id,
      'testId': instance.testId,
      'geschlecht': instance.geschlecht,
      'alterMin': instance.alterMin,
      'alterMax': instance.alterMax,
      'wertMin': instance.wertMin,
      'wertMax': instance.wertMax,
      'einheit': instance.einheit,
    };
