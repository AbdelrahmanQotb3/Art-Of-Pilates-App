import 'package:art_of_pilates/app/config/base_response/base_response.dart';
import 'package:art_of_pilates/app/features/schedule-sessions/data/data_source/sessions_data_source_contract.dart';
import 'package:art_of_pilates/app/features/schedule-sessions/data/model/one_session_response.dart';
import 'package:art_of_pilates/app/features/schedule-sessions/data/model/sessions_response.dart';
import 'package:art_of_pilates/app/features/schedule-sessions/domain/model/sessions_model.dart';
import 'package:art_of_pilates/app/features/schedule-sessions/domain/repo/sessions_repo_contract.dart';
import 'package:art_of_pilates/app/features/services/domain/model/services_model.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: SessionsRepoContract)
class SessionsRepoImpl implements SessionsRepoContract {
  final SessionsDataSourceContract dataSource;

  SessionsRepoImpl(this.dataSource);
  @override
  Future<BaseResponse<SessionsModel>> getAllSessions() async {
    final response = await dataSource.getSessions();
    switch (response) {
      case SuccessResponse<SessionsResponse>():
        final SessionsModel sessionsModel = SessionsModel(
          message: response.data.message,
          sessions: response.data.sessions
              ?.map(
                (e) => SessionEntity(
                  id: e.id,
                  startTime: e.startTime,
                  endTime: e.endTime,
                  serviceId: e.serviceId,
                  staffMemberId: e.staffMemberId,
                  currentParticipants: e.currentParticipants,
                  maxParticipants: e.maxParticipants,
                  status: e.status,
                  name: e.name,
                  service: e.service != null
                      ? ServiceEntity(
                          name: e.service!.name,
                          location: e.service!.location,
                          id: e.service!.id,
                          price: e.service!.price,
                        )
                      : null,
                  staffMember: e.staffMember != null
                      ? StaffMemberEntity(
                          name: e.staffMember!.name,
                          email: e.staffMember!.email,
                        )
                      : null,
                ),
              )
              .toList(),
        );
        return SuccessResponse(data: sessionsModel);

      case ErrorResponse(error: final error):
        return ErrorResponse(error: error);
    }
  }

  @override
  Future<BaseResponse<SessionEntity>> getOneSession(String id) async {
    final response = await dataSource.getOneSession(id);
    switch (response) {
      case SuccessResponse<OneSessionResponse>():
        SessionEntity sessionEntity = SessionEntity(
          id: response.data.session!.id,
          startTime: response.data.session!.startTime,
          endTime: response.data.session!.endTime,
          serviceId: response.data.session!.serviceId,
          staffMemberId: response.data.session!.staffMemberId,
          currentParticipants: response.data.session!.currentParticipants,
          maxParticipants: response.data.session!.maxParticipants,
          status: response.data.session!.status,
          name: response.data.session!.name,
          description: response.data.session!.description,
          service: response.data.session!.service != null
              ? ServiceEntity(
                  name: response.data.session!.service!.name,
                  id: response.data.session!.service!.id,
                  location: response.data.session!.service!.location,
                  price: response.data.session!.service!.price,
                  description: response.data.session!.service!.description,
                )
              : null,
          staffMember: response.data.session!.staffMember != null
              ? StaffMemberEntity(
                  name: response.data.session!.staffMember!.name,
                  email: response.data.session!.staffMember!.email,
                )
              : null,
        );
        return SuccessResponse(data: sessionEntity);
      case ErrorResponse(error: final error):
        return ErrorResponse(error: error);
    }
  }
}
