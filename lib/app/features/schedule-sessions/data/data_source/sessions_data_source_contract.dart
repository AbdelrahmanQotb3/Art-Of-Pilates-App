import 'package:art_of_pilates/app/config/base_response/base_response.dart';
import 'package:art_of_pilates/app/features/schedule-sessions/data/model/one_session_response.dart';
import 'package:art_of_pilates/app/features/schedule-sessions/data/model/sessions_response.dart';

abstract class SessionsDataSourceContract {
  Future<BaseResponse<SessionsResponse>> getSessions();

  Future<BaseResponse<OneSessionResponse>> getOneSession(String id);
}