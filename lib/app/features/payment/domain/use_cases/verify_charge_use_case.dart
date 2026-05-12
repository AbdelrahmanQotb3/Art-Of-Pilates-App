import 'package:art_of_pilates/app/config/base_response/base_response.dart';
import 'package:art_of_pilates/app/features/payment/domain/model/verify_charge_model.dart';
import 'package:art_of_pilates/app/features/payment/domain/repo/payment_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class VerifyChargeUseCase {
  final PaymentRepoContract _paymentRepoContract;

  VerifyChargeUseCase(this._paymentRepoContract);

  Future<BaseResponse<VerifyChargeModel>> call(String chargeId) async {
    return await _paymentRepoContract.verifyCharge(chargeId);
  }
}