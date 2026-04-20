import 'package:art_of_pilates/app/features/services/domain/model/services_model.dart';

class PricingPlanModel {
  final String? message;
  final List<PricingPlanEntity>? plans;

  PricingPlanModel({this.message, this.plans});

  PricingPlanModel copyWith({String? message, List<PricingPlanEntity>? plans}) {
    return PricingPlanModel(
      message: message ?? this.message,
      plans: plans ?? this.plans,
    );
  }
}

class PricingPlanEntity {
  final int? id;
  final String? planName;
  final String? status;
  final String? imageUrl;
  final double? price;
  final String? currency;
  final String? duration;
  final int? totalSessions;
  final bool? offerAsPackage;
  final String? planDetails;
  final List<ServiceEntity>? services;

  PricingPlanEntity({
    this.id,
    this.planName,
    this.status,
    this.imageUrl,
    this.price,
    this.currency,
    this.duration,
    this.totalSessions,
    this.offerAsPackage,
    this.planDetails,
    this.services,
  });

  PricingPlanEntity copyWith({
    int? id,
    String? planName,
    String? status,
    String? imageUrl,
    double? price,
    String? currency,
    String? duration,
    int? totalSessions,
    bool? offerAsPackage,
    String? planDetails,
    List<ServiceEntity>? services,
  }) {
    return PricingPlanEntity(
      id: id ?? this.id,
      planName: planName ?? this.planName,
      status: status ?? this.status,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      currency: currency ?? this.currency,
      duration: duration ?? this.duration,
      totalSessions: totalSessions ?? this.totalSessions,
      offerAsPackage: offerAsPackage ?? this.offerAsPackage,
      planDetails: planDetails ?? this.planDetails,
      services: services ?? this.services,
    );
  }
}
