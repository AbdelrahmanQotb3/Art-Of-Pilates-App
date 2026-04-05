import 'package:art_of_pilates/app/config/end_points.dart';
import 'package:art_of_pilates/app/features/signup/data/model/signup_response.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'signup_api_client.g.dart';

@RestApi(baseUrl: EndPoints.baseUrl)
@injectable
abstract class SignupApiClient {
  @factoryMethod
  factory SignupApiClient(Dio dio) = _SignupApiClient;

  @POST(EndPoints.signup)
  Future<SignupResponse> signup(@Body() Map<String, dynamic> body);
}