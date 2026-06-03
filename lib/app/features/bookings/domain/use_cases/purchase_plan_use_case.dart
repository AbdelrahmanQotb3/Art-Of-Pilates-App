import 'package:art_of_pilates/app/config/base_response/base_response.dart';
import 'package:art_of_pilates/app/features/bookings/domain/model/purchase_plan_model.dart';
import 'package:art_of_pilates/app/features/bookings/domain/repo/bookings_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class PurchasePlanUseCase {
  final BookingsRepoContract _repo;
  PurchasePlanUseCase(this._repo);

  Future<BaseResponse<PurchasePlanModel>> call(
    int pricingPlanId,
    String? startDate,
  ) {
    return _repo.purchasePlan(pricingPlanId, startDate);
  }
}