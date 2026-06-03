// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'announcments_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnnouncmentsResponse _$AnnouncmentsResponseFromJson(
  Map<String, dynamic> json,
) => AnnouncmentsResponse(
  message: json['message'] as String?,
  announcements: (json['announcements'] as List<dynamic>?)
      ?.map((e) => Announcements.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$AnnouncmentsResponseToJson(
  AnnouncmentsResponse instance,
) => <String, dynamic>{
  'message': instance.message,
  'announcements': instance.announcements?.map((e) => e.toJson()).toList(),
};

Announcements _$AnnouncementsFromJson(Map<String, dynamic> json) =>
    Announcements(
      id: json['id'] as String?,
      title: json['title'] as String?,
      content: json['content'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      type: json['type'] as String?,
    );

Map<String, dynamic> _$AnnouncementsToJson(Announcements instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'type': instance.type,
    };
