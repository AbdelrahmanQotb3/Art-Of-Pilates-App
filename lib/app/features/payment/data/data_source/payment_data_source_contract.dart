import 'package:art_of_pilates/app/config/base_response/base_response.dart';
import 'package:art_of_pilates/app/features/payment/data/model/create_charge_response.dart';
import 'package:art_of_pilates/app/features/payment/data/model/verify_charge_response.dart';

abstract class PaymentDataSourceContract {
  Future<BaseResponse<CreateChargeResponse>> createCharge(String sessionId);
  Future<BaseResponse<CreateChargeResponse>> createPlanCharge(int planId);
  Future<BaseResponse<VerifyChargeResponse>> verifyCharge(String chargeId);
}