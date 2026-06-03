class AnnouncmentsModel {
  final String? message;
  final List<AnnouncmentEntity>? announcements;

  const AnnouncmentsModel({this.message, this.announcements});

  AnnouncmentsModel copyWith({
    String? message,
    List<AnnouncmentEntity>? announcements,
  }) {
    return AnnouncmentsModel(
      message: message ?? this.message,
      announcements: announcements ?? this.announcements,
    );
  }
}

class AnnouncmentEntity {
  final String? id;
  final String? title;
  final String? content;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? type;

  const AnnouncmentEntity({
    this.id,
    this.title,
    this.content,
    this.createdAt,
    this.updatedAt,
    this.type,
  });

  AnnouncmentEntity copyWith({
    String? id,
    String? title,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? type,
  }) {
    return AnnouncmentEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      type: type ?? this.type,
    );
  }
}
