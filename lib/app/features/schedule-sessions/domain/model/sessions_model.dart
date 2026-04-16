import 'package:art_of_pilates/app/features/services/domain/model/services_model.dart';

class SessionsModel {
  final String? message;
  final List<SessionEntity>? sessions;

  const SessionsModel({this.message, this.sessions});
  SessionsModel copyWith({String? message, List<SessionEntity>? sessions}) =>
      SessionsModel(
        message: message ?? this.message,
        sessions: sessions ?? this.sessions,
      );
}

class SessionEntity {
  final String? id;
  final String? name;
  final String? startTime;
  final String? endTime;
  final String? status;
  final int? maxParticipants;
  final int? currentParticipants;
  final String? serviceId;
  final String? staffMemberId;
  final String? description;
  final ServiceEntity? service;
  final StaffMemberEntity? staffMember;

  const SessionEntity({
    this.id,
    this.name,
    this.startTime,
    this.endTime,
    this.status,
    this.maxParticipants,
    this.currentParticipants,
    this.serviceId,
    this.staffMemberId,
    this.service,
    this.staffMember,
    this.description
  });

  SessionEntity copyWith({
    String? id,
    String? name,
    String? startTime,
    String? endTime,
    String? status,
    int? maxParticipants,
    int? currentParticipants,
    String? serviceId,
    String? staffMemberId,
    ServiceEntity? service,
    StaffMemberEntity? staffMember,
    String? description
  }) {
    return SessionEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      status: status ?? this.status,
      maxParticipants: maxParticipants ?? this.maxParticipants,
      currentParticipants: currentParticipants ?? this.currentParticipants,
      serviceId: serviceId ?? this.serviceId,
      staffMemberId: staffMemberId ?? this.staffMemberId,
      service: service ?? this.service,
      staffMember: staffMember ?? this.staffMember,
      description: description ?? this.description
    );
  }
}

class StaffMemberEntity {
  final String? name;
  final String? email;
  final String? profilePic;

  const StaffMemberEntity({this.name, this.email, this.profilePic});

  StaffMemberEntity copyWith({String? name, String? email, String? profilePic}) =>
      StaffMemberEntity(
        name: name ?? this.name,
        email: email ?? this.email,
        profilePic: profilePic ?? this.profilePic,
      );
}
