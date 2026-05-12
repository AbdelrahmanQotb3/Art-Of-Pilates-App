import 'package:art_of_pilates/app/config/base_response/base_response.dart';
import 'package:art_of_pilates/app/features/payment/domain/model/create_charge_model.dart';
import 'package:art_of_pilates/app/features/payment/domain/model/verify_charge_model.dart';
abstract class PaymentRepoContract {

  Future<BaseResponse<CreateChargeModel>> createCharge(String sessionId);
  Future<BaseResponse<CreateChargeModel>> createPlanCharge(int planId);
  Future<BaseResponse<VerifyChargeModel>> verifyCharge(String chargeId);
}