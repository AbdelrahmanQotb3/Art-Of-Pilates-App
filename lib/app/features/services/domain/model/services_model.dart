import 'package:art_of_pilates/app/features/schedule-sessions/domain/model/sessions_model.dart';

class ServicesModel {
  String? message;
  List<ServiceEntity>? services;

  ServicesModel({this.message, this.services});

  ServicesModel copyWith({String? message, List<ServiceEntity>? services}) {
    return ServicesModel(
      message: message ?? this.message,
      services: services ?? this.services,
    );
  }
}

class ServiceEntity {
  final String? id;
  final String? createdAt;
  final String? updatedAt;
  final String? name;
  final String? imageUrl;
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
  final String? description;
  final List<SessionEntity>? sessions;

  ServiceEntity({
    this.id, this.createdAt, this.updatedAt, this.name,
    this.imageUrl, this.price, this.currency, this.isVisible,
    this.index, this.bufferTime, this.paymentType, this.paymentPriceType,
    this.paymentAmount, this.paymentPref, this.location,
    this.bookingPolicy, this.sessions, this.description
  });
}