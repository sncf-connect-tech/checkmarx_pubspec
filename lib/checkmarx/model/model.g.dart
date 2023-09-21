// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PackageInfo _$PackageInfoFromJson(Map<String, dynamic> json) => PackageInfo(
      name: json['name'] as String,
      type: $enumDecode(_$RepositoryTypeEnumMap, json['type']),
      version: json['version'] as String,
    );

Map<String, dynamic> _$PackageInfoToJson(PackageInfo instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': _$RepositoryTypeEnumMap[instance.type]!,
      'version': instance.version,
    };

const _$RepositoryTypeEnumMap = {
  RepositoryType.pub: 'pub',
  RepositoryType.npm: 'npm',
};

ScannedPackageInfo _$ScannedPackageInfoFromJson(Map<String, dynamic> json) =>
    ScannedPackageInfo(
      type: $enumDecode(_$RepositoryTypeEnumMap, json['type']),
      name: json['name'] as String,
      version: json['version'] as String,
      risks: (json['risks'] as List<dynamic>)
          .map((e) => Risk.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as String,
    );

Map<String, dynamic> _$ScannedPackageInfoToJson(ScannedPackageInfo instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': _$RepositoryTypeEnumMap[instance.type]!,
      'version': instance.version,
      'status': instance.status,
      'risks': instance.risks,
    };

Risk _$RiskFromJson(Map<String, dynamic> json) => Risk(
      id: json['id'] as String,
      description: json['description'] as String,
      title: json['title'] as String,
      score: json['score'] as int,
    );

Map<String, dynamic> _$RiskToJson(Risk instance) => <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'title': instance.title,
      'score': instance.score,
    };
