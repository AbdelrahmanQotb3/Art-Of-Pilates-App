// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookings_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingsResponse _$BookingsResponseFromJson(Map<String, dynamic> json) =>
    BookingsResponse(
      message: json['message'] as String?,
      bookings: (json['bookings'] as List<dynamic>?)
          ?.map((e) => Bookings.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BookingsResponseToJson(BookingsResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'bookings': instance.bookings,
    };

Bookings _$BookingsFromJson(Map<String, dynamic> json) => Bookings(
  id: json['id'] as String?,
  userId: (json['userId'] as num?)?.toInt(),
  sessionId: json['sessionId'] as String?,
  userPlanId: json['userPlanId'] as String?,
  createdAt: json['createdAt'] as String?,
  updatedAt: json['updatedAt'] as String?,
  session: json['session'] == null
      ? null
      : Sessions.fromJson(json['session'] as Map<String, dynamic>),
  userPlan: json['userPlan'] == null
      ? null
      : UserPlan.fromJson(json['userPlan'] as Map<String, dynamic>),
);

Map<String, dynamic> _$BookingsToJson(Bookings instance) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'sessionId': instance.sessionId,
  'userPlanId': instance.userPlanId,
  'createdAt': instance.createdAt,
  'updatedAt': instance.updatedAt,
  'session': instance.session,
  'userPlan': instance.userPlan,
};

UserPlan _$UserPlanFromJson(Map<String, dynamic> json) => UserPlan(
  id: json['id'] as String?,
  createdAt: json['createdAt'] as String?,
  updatedAt: json['updatedAt'] as String?,
  userId: (json['userId'] as num?)?.toInt(),
  pricingPlanId: (json['pricingPlanId'] as num?)?.toInt(),
  sessionsTotal: (json['sessionsTotal'] as num?)?.toInt(),
  sessionsUsed: (json['sessionsUsed'] as num?)?.toInt(),
  sessionsLeft: (json['sessionsLeft'] as num?)?.toInt(),
  status: json['status'] as String?,
  startDate: json['startDate'] as String?,
  expiryDate: json['expiryDate'] as String?,
  pricingPlan: json['pricingPlan'] == null
      ? null
      : Plan.fromJson(json['pricingPlan'] as Map<String, dynamic>),
);

Map<String, dynamic> _$UserPlanToJson(UserPlan instance) => <String, dynamic>{
  'id': instance.id,
  'createdAt': instance.createdAt,
  'updatedAt': instance.updatedAt,
  'userId': instance.userId,
  'pricingPlanId': instance.pricingPlanId,
  'sessionsTotal': instance.sessionsTotal,
  'sessionsUsed': instance.sessionsUsed,
  'sessionsLeft': instance.sessionsLeft,
  'status': instance.status,
  'startDate': instance.startDate,
  'expiryDate': instance.expiryDate,
  'pricingPlan': instance.pricingPlan,
};
