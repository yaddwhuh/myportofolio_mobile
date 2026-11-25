import 'package:json_annotation/json_annotation.dart';

part 'project.g.dart';

/// Portfolio project synchronized with the Django REST Framework API.
@JsonSerializable(fieldRename: FieldRename.snake)
class Project {
  const Project({
    this.id,
    required this.projectName,
    required this.description,
    required this.technologies,
    required this.projectLink,
    this.projectImageUrl = '',
  });

  factory Project.fromJson(Map<String, dynamic> json) =>
      _$ProjectFromJson(json);

  @JsonKey(includeToJson: false)
  final String? id;
  final String projectName;
  final String description;
  final String technologies;
  final String projectLink;

  @JsonKey(defaultValue: '')
  final String projectImageUrl;

  Map<String, dynamic> toJson() => _$ProjectToJson(this);
}
