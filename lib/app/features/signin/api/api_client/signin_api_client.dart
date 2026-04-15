import 'package:art_of_pilates/app/config/app_end_points.dart';
import 'package:art_of_pilates/app/features/signin/data/model/signin_response.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'signin_api_client.g.dart';

@RestApi(baseUrl: AppEndPoints.baseUrl)
@injectable
abstract class SigninApiClient {
  @factoryMethod
  factory SigninApiClient(Dio dio) = _SigninApiClient;

  @POST(AppEndPoints.signin)
  Future<SigninResponse> signin(@Body() Map<String, dynamic> body);

  @POST(AppEndPoints.signinWithSocial)
  Future<SigninResponse> signinWithSocial(@Body() Map<String, dynamic> body);
}
