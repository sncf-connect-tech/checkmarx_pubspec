import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

enum RepositoryType {
  pub,
  npm,
}

@JsonSerializable()
class PackageInfo {
  String name;
  RepositoryType type;
  String version;

  PackageInfo({
    required this.name,
    required this.type,
    required this.version,
  });

  factory PackageInfo.fromJson(Map<String, dynamic> json) => _$PackageInfoFromJson(json);
  Map<String, dynamic> toJson() => _$PackageInfoToJson(this);
}

@JsonSerializable()
class ScannedPackageInfo extends PackageInfo {
  String status;
  List<Risk> risks;

  ScannedPackageInfo({
    required super.type,
    required super.name,
    required super.version,
    required this.risks,
    required this.status,
  });

  factory ScannedPackageInfo.fromJson(Map<String, dynamic> json) => _$ScannedPackageInfoFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$ScannedPackageInfoToJson(this);
}

@JsonSerializable()
class Risk {
  String id;
  String description;
  String title;
  int score;

  Risk({
    required this.id,
    required this.description,
    required this.title,
    required this.score,
  });

  factory Risk.fromJson(Map<String, dynamic> json) => _$RiskFromJson(json);
  Map<String, dynamic> toJson() => _$RiskToJson(this);
}
