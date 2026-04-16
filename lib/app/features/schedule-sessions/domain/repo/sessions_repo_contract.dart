import 'package:art_of_pilates/app/config/base_response/base_response.dart';
import 'package:art_of_pilates/app/features/schedule-sessions/domain/model/sessions_model.dart';

abstract class SessionsRepoContract {

  Future<BaseResponse<SessionsModel>> getAllSessions();

  Future<BaseResponse<SessionEntity>> getOneSession(String id);
}