import 'package:art_of_pilates/app/config/app_end_points.dart';
import 'package:art_of_pilates/app/features/schedule-sessions/data/model/one_session_response.dart';
import 'package:art_of_pilates/app/features/schedule-sessions/data/model/sessions_response.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'sessions_api_client.g.dart';

@injectable
@RestApi(baseUrl: AppEndPoints.baseUrl)
abstract class SessionsApiClient {
  @factoryMethod
  factory SessionsApiClient(Dio dio) => _SessionsApiClient(dio);

  @GET(AppEndPoints.getAllSessions)
  Future<SessionsResponse> getSessions();

  @GET(AppEndPoints.getOneSession)
  Future<OneSessionResponse> getOneSession(@Query("id") String id);
}