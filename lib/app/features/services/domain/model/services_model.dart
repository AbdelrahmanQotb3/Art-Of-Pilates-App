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
  final List<SessionEntity>? sessions;

  ServiceEntity({
    this.id, this.createdAt, this.updatedAt, this.name,
    this.imageUrl, this.price, this.currency, this.isVisible,
    this.index, this.bufferTime, this.paymentType, this.paymentPriceType,
    this.paymentAmount, this.paymentPref, this.location,
    this.bookingPolicy, this.sessions,
  });
}
class SessionsModel {
  String? message;
  List<SessionEntity>? sessions;

  SessionsModel({this.message, this.sessions});

  SessionsModel copyWith({String? message, List<SessionEntity>? sessions}) {
    return SessionsModel(
      message: message ?? this.message,
      sessions: sessions ?? this.sessions,
    );
  }
}

class SessionEntity {
  final String? id;
  final String? startTime;
  final String? endTime;
  final String? serviceId;
  final String? staffMemberId;
  final String? serviceName; // lightweight ref to avoid circular imports
  final String? staffName; // lightweight ref

  SessionEntity({
    this.id,
    this.startTime,
    this.endTime,
    this.serviceId,
    this.staffMemberId,
    this.serviceName,
    this.staffName,
  });

  SessionEntity copyWith({
    String? id,
    String? startTime,
    String? endTime,
    String? serviceId,
    String? staffMemberId,
    String? serviceName,
    String? staffName,
  }) {
    return SessionEntity(
      id: id ?? this.id,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      serviceId: serviceId ?? this.serviceId,
      staffMemberId: staffMemberId ?? this.staffMemberId,
      serviceName: serviceName ?? this.serviceName,
      staffName: staffName ?? this.staffName,
    );
  }
}

