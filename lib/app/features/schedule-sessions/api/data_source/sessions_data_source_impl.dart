import 'package:art_of_pilates/app/config/base_response/base_response.dart';
import 'package:art_of_pilates/app/features/schedule-sessions/api/api_client/sessions_api_client.dart';
import 'package:art_of_pilates/app/features/schedule-sessions/data/data_source/sessions_data_source_contract.dart';
import 'package:art_of_pilates/app/features/schedule-sessions/data/model/one_session_response.dart';
import 'package:art_of_pilates/app/features/schedule-sessions/data/model/sessions_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: SessionsDataSourceContract)
class SessionsDataSourceImpl implements SessionsDataSourceContract {
  final SessionsApiClient apiClient;

  SessionsDataSourceImpl(this.apiClient);

  @override
  Future<BaseResponse<SessionsResponse>> getSessions() async {
    try {
      final response = await apiClient.getSessions();
      return SuccessResponse(data: response);
    } on Exception catch (e) {
      return ErrorResponse(error: e);
    }
  }

  @override
  Future<BaseResponse<OneSessionResponse>> getOneSession(String id) async {
    try{
      final response = await apiClient.getOneSession(id);
      return SuccessResponse(data: response);
    }on Exception catch(e){
      return ErrorResponse(error: e);
    }
  }
}
