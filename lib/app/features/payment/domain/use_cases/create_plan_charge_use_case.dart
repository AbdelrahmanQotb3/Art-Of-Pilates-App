import 'package:art_of_pilates/app/config/base_response/base_response.dart';
import 'package:art_of_pilates/app/features/payment/domain/model/create_charge_model.dart';
import 'package:art_of_pilates/app/features/payment/domain/repo/payment_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class CreatePlanChargeUseCase {
  final PaymentRepoContract _paymentRepo;

  CreatePlanChargeUseCase(this._paymentRepo);
  Future<BaseResponse<CreateChargeModel>> call(int planId)async {
    return await _paymentRepo.createPlanCharge(planId);
  }
}