import 'package:art_of_pilates/app/config/app_end_points.dart';
import 'package:art_of_pilates/app/features/packages/data/model/pricing_plan_response.dart';
import 'package:art_of_pilates/app/features/packages/data/model/pricing_plans_response.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'packages_api_client.g.dart';

@injectable
@RestApi(baseUrl: AppEndPoints.baseUrl)
abstract class PackagesApiClient {

  @factoryMethod
  factory PackagesApiClient(Dio dio) = _PackagesApiClient;

  @GET(AppEndPoints.getAllPackages)
  Future<PricingPlansResponse> getAllPackages();

  @GET(AppEndPoints.getOnePackage)
  Future<PricingPlanResponse> getPackageById(@Query("planId") int id);
}