import 'package:art_of_pilates/app/config/base_response/base_response.dart';
import 'package:art_of_pilates/app/features/payment/data/data_source/payment_data_source_contract.dart';
import 'package:art_of_pilates/app/features/payment/data/model/create_charge_response.dart';
import 'package:art_of_pilates/app/features/payment/data/model/verify_charge_response.dart';
import 'package:art_of_pilates/app/features/payment/domain/model/create_charge_model.dart';
import 'package:art_of_pilates/app/features/payment/domain/model/verify_charge_model.dart';
import 'package:art_of_pilates/app/features/payment/domain/repo/payment_repo_contract.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: PaymentRepoContract)
class PaymentRepoImpl implements PaymentRepoContract {
  final PaymentDataSourceContract _paymentDataSource;

  PaymentRepoImpl(this._paymentDataSource);
  @override
  Future<BaseResponse<CreateChargeModel>> createCharge(String sessionId) async {
    final response = await _paymentDataSource.createCharge(sessionId);
    switch (response) {
      case SuccessResponse<CreateChargeResponse>():
        final CreateChargeModel model = CreateChargeModel(
          chargeId: response.data.chargeId,
          paymentUrl: response.data.paymentUrl,
          status: response.data.status,
        );
        return SuccessResponse(data: model);
      case ErrorResponse<CreateChargeResponse>():
        return ErrorResponse(error: response.error);
    }
  }

  @override
  Future<BaseResponse<VerifyChargeModel>> verifyCharge(String chargeId) async {
    final response = await _paymentDataSource.verifyCharge(chargeId);
    switch (response) {
      case SuccessResponse<VerifyChargeResponse>():
        final VerifyChargeModel model = VerifyChargeModel(
          success: response.data.success,
          status: response.data.status,
        );
        return SuccessResponse(data: model);
      case ErrorResponse<VerifyChargeResponse>():
        return ErrorResponse(error: response.error);
    }
  }

  @override
  Future<BaseResponse<CreateChargeModel>> createPlanCharge(int planId) async {
    final response = await _paymentDataSource.createPlanCharge(planId);
    switch (response) {
      case SuccessResponse<CreateChargeResponse>():
        final CreateChargeModel model = CreateChargeModel(
          chargeId: response.data.chargeId,
          paymentUrl: response.data.paymentUrl,
          status: response.data.status,
        );
        return SuccessResponse(data: model);
      case ErrorResponse<CreateChargeResponse>():
        return ErrorResponse(error: response.error);
    }
  }
}
