import 'package:art_of_pilates/app/config/base_response/base_response.dart';
import 'package:art_of_pilates/app/features/bookings/domain/model/check_plan_model.dart';
import 'package:art_of_pilates/app/features/bookings/domain/repo/bookings_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class CheckPlanForSessionUseCase {
  final BookingsRepoContract _repo;
  CheckPlanForSessionUseCase(this._repo);

  Future<BaseResponse<CheckPlanModel>> call(String sessionId) =>
      _repo.checkPlanForSession(sessionId);
}
