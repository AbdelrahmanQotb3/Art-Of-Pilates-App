import 'package:json_annotation/json_annotation.dart';

part 'announcments_response.g.dart';

@JsonSerializable(explicitToJson: true)
class AnnouncmentsResponse {
  final String? message;
  final List<Announcements>? announcements;

  AnnouncmentsResponse({
    this.message,
    this.announcements,
  });

  factory AnnouncmentsResponse.fromJson(Map<String, dynamic> json) =>
      _$AnnouncmentsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AnnouncmentsResponseToJson(this);
}

@JsonSerializable()
class Announcements {
  final String? id;
  final String? title;
  final String? content;
  final String? createdAt;
  final String? updatedAt;
  final String? type;

  Announcements({
    this.id,
    this.title,
    this.content,
    this.createdAt,
    this.updatedAt,
    this.type,
  });

  factory Announcements.fromJson(Map<String, dynamic> json) =>
      _$AnnouncementsFromJson(json);

  Map<String, dynamic> toJson() => _$AnnouncementsToJson(this);
}