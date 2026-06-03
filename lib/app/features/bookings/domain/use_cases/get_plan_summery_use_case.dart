import 'package:art_of_pilates/app/config/base_response/base_response.dart';
import 'package:art_of_pilates/app/features/bookings/domain/model/my_plan_summery_model.dart';
import 'package:art_of_pilates/app/features/bookings/domain/repo/bookings_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetPlanSummeryUseCase {
  final BookingsRepoContract _bookingsRepo;

  GetPlanSummeryUseCase(this._bookingsRepo);

  Future<BaseResponse<MyPlanSummeryModel>> call() async {
    return await _bookingsRepo.getPlanSummery();
  }
}