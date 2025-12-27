// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AccountModel _$AccountModelFromJson(Map<String, dynamic> json) =>
    _AccountModel(
      id: (json['id'] as num).toInt(),
      secretKey: json['secretKey'] as String,
      title: json['title'] as String,
      length: (json['length'] as num).toInt(),
      interval: (json['interval'] as num).toInt(),
      issuer: json['issuer'] as String,
    );

Map<String, dynamic> _$AccountModelToJson(_AccountModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'secretKey': instance.secretKey,
      'title': instance.title,
      'length': instance.length,
      'interval': instance.interval,
      'issuer': instance.issuer,
    };
