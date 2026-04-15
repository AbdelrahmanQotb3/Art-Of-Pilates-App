import 'package:art_of_pilates/app/config/app_end_points.dart';
import 'package:art_of_pilates/app/features/services/data/model/one_service_response.dart';
import 'package:art_of_pilates/app/features/services/data/model/services_response.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'services_api_client.g.dart';

@injectable
@RestApi(baseUrl: AppEndPoints.baseUrl)
abstract class ServicesApiClient {
  @factoryMethod
  factory ServicesApiClient(Dio dio) = _ServicesApiClient;

  @GET(AppEndPoints.getAllServices)
  Future<ServicesResponse> getAllServices();

  @GET(AppEndPoints.getOneService)
  Future<OneServiceResponse> getOneService(@Query("id") String id);
}
