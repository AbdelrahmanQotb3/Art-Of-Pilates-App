import 'package:json_annotation/json_annotation.dart';

part 'book_plan_response.g.dart';

@JsonSerializable()
class BookPlanResponse {
  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'bookedCount')
  final int? bookedCount;

  @JsonKey(name: 'sessionsLeft')
  final int? sessionsLeft;

  @JsonKey(name: 'bookedSessions')
  final List<BookedSessionDto>? bookedSessions;

  BookPlanResponse({
    this.message,
    this.bookedCount,
    this.sessionsLeft,
    this.bookedSessions,
  });

  factory BookPlanResponse.fromJson(Map<String, dynamic> json) =>
      _$BookPlanResponseFromJson(json);
}

@JsonSerializable()
class BookedSessionDto {
  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'startTime')
  final String? startTime;

  @JsonKey(name: 'endTime')
  final String? endTime;

  @JsonKey(name: 'staffMember')
  final String? staffMember;

  BookedSessionDto({
    this.id,
    this.name,
    this.startTime,
    this.endTime,
    this.staffMember,
  });

  factory BookedSessionDto.fromJson(Map<String, dynamic> json) =>
      _$BookedSessionDtoFromJson(json);
}