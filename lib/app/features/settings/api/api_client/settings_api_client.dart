import 'package:art_of_pilates/app/config/app_end_points.dart';
import 'package:art_of_pilates/app/features/settings/data/model/delete_account_response.dart';
import 'package:art_of_pilates/app/features/settings/data/model/logout_response.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'settings_api_client.g.dart';

@RestApi(baseUrl: AppEndPoints.baseUrl)
@injectable
abstract class SettingsApiClient {
  @factoryMethod
  factory SettingsApiClient(Dio dio) = _SettingsApiClient;

  @POST(AppEndPoints.logout)
  Future<LogOutResponse> logout();

  @POST(AppEndPoints.deleteAccount)
  Future<DeleteAccountResponse> deleteAccount(@Query("id") int id);
}