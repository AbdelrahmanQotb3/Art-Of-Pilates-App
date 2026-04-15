import 'package:art_of_pilates/app/config/app_end_points.dart';
import 'package:art_of_pilates/app/features/signup/data/model/signup_response.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'signup_api_client.g.dart';

@RestApi(baseUrl: AppEndPoints.baseUrl)
@injectable
abstract class SignupApiClient {
  @factoryMethod
  factory SignupApiClient(Dio dio) = _SignupApiClient;

  @POST(AppEndPoints.signup)
  Future<SignupResponse> signup(@Body() Map<String, dynamic> body);

  @POST(AppEndPoints.signupWithSocial)
  Future<SignupResponse> signupWithSocial(@Body() Map<String, dynamic> body);
}
