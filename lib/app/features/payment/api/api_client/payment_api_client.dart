import 'package:art_of_pilates/app/config/app_end_points.dart';
import 'package:art_of_pilates/app/features/payment/data/model/create_charge_response.dart';
import 'package:art_of_pilates/app/features/payment/data/model/verify_charge_response.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'payment_api_client.g.dart';

@injectable
@RestApi(baseUrl: AppEndPoints.baseUrl)
abstract class PaymentApiClient {
  @factoryMethod
  factory PaymentApiClient(Dio dio) => _PaymentApiClient(dio);

  @POST(AppEndPoints.createCharge)
  Future<CreateChargeResponse> createCharge(@Body() Map<String, dynamic> body);

  @POST(AppEndPoints.createPlanCharge)
  Future<CreateChargeResponse> createPlanCharge(@Body() Map<String, dynamic> body);

  @GET(AppEndPoints.verifyPayment)
  Future<VerifyChargeResponse> verifyCharge(@Path("chargeId") String chargeId);
}