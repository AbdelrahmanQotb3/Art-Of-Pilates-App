import 'package:art_of_pilates/app/features/schedule-sessions/data/model/sessions_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'services_response.g.dart';

@JsonSerializable()
class ServicesResponse {
  @JsonKey(name: 'Message')
  final String? message;
  
  @JsonKey(name: 'Services')
  final List<Service>? services;

  ServicesResponse({this.message, this.services});

  factory ServicesResponse.fromJson(Map<String, dynamic> json) => _$ServicesResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ServicesResponseToJson(this);
}

@JsonSerializable()
class Service {
  final String? id;
  final String? createdAt;
  final String? updatedAt;
  final String? name;
  final String? imageUrl;
  final String? tagLine;
  final String? description;
  final int? maxParticipants;
  final bool? onlineBookings;
  final String? bookingFormId;
  final int? price;
  final String? currency;
  final bool? isVisible;
  final int? index;
  final String? bufferTime;
  final String? paymentType;
  final String? paymentPriceType;
  final double? paymentAmount;
  final String? paymentPref;
  final String? location;
  final String? bookingPolicy;
  final dynamic bookingForm;
  final List<Sessions>? sessions;

  Service({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.imageUrl,
    this.tagLine,
    this.description,
    this.maxParticipants,
    this.onlineBookings,
    this.bookingFormId,
    this.price,
    this.currency,
    this.isVisible,
    this.index,
    this.bufferTime,
    this.paymentType,
    this.paymentPriceType,
    this.paymentAmount,
    this.paymentPref,
    this.location,
    this.bookingPolicy,
    this.bookingForm,
    this.sessions,
  });

  factory Service.fromJson(Map<String, dynamic> json) => _$ServiceFromJson(json);
  Map<String, dynamic> toJson() => _$ServiceToJson(this);
}