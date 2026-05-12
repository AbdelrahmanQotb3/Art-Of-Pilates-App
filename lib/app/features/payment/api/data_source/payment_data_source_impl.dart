import 'package:art_of_pilates/app/config/base_response/base_response.dart';
import 'package:art_of_pilates/app/core/util/exceptions/payment/payment_exception.dart';
import 'package:art_of_pilates/app/features/payment/api/api_client/payment_api_client.dart';
import 'package:art_of_pilates/app/features/payment/data/data_source/payment_data_source_contract.dart';
import 'package:art_of_pilates/app/features/payment/data/model/create_charge_response.dart';
import 'package:art_of_pilates/app/features/payment/data/model/verify_charge_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: PaymentDataSourceContract)
class PaymentDataSourceImpl implements PaymentDataSourceContract {
  final PaymentApiClient _paymentApiClient;

  PaymentDataSourceImpl(this._paymentApiClient);

  @override
  Future<BaseResponse<CreateChargeResponse>> createCharge(
    String sessionId,
  ) async {
    try {
      final response = await _paymentApiClient.createCharge({
        "sessionId": sessionId,
      });
      return SuccessResponse(data: response);
    } on Exception catch (e) {
      return ErrorResponse(error: PaymentException(error: e.toString()));
    }
  }

  @override
  Future<BaseResponse<VerifyChargeResponse>> verifyCharge(
    String chargeId,
  ) async {
    try {
      final response = await _paymentApiClient.verifyCharge(chargeId);
      return SuccessResponse(data: response);
    } on Exception catch (e) {
      return ErrorResponse(error: PaymentException(error: e.toString()));
    }
  }

  @override
  Future<BaseResponse<CreateChargeResponse>> createPlanCharge(
    int planId,
  ) async {
    try {
      final response = await _paymentApiClient.createPlanCharge({
        "planId": planId,
      });
      return SuccessResponse(data: response);
    } on Exception catch (e) {
      return ErrorResponse(error: PaymentException(error: e.toString()));
    }
  }
}
