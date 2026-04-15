import 'package:art_of_pilates/app/config/app_end_points.dart';
import 'package:art_of_pilates/app/features/profile/data/model/current_user_response.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'profile_api_client.g.dart';

@RestApi(baseUrl: AppEndPoints.baseUrl)
@injectable
abstract class ProfileApiClient {
  @factoryMethod
  factory ProfileApiClient(Dio dio) = _ProfileApiClient;

  @GET(AppEndPoints.getUser)
  Future<CurrentUserResponse> getUser(@Query("id") String id);

  @PATCH(AppEndPoints.editUser)
  Future<CurrentUserResponse> editUser(@Query("id") String id , @Body() Map<String, dynamic> body);
}