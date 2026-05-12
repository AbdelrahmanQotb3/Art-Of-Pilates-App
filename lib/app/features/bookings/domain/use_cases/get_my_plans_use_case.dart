import 'package:art_of_pilates/app/config/base_response/base_response.dart';
import 'package:art_of_pilates/app/features/bookings/domain/model/my_plans_model.dart';
import 'package:art_of_pilates/app/features/bookings/domain/repo/bookings_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetMyPlansUseCase {
  final BookingsRepoContract _repo;

  GetMyPlansUseCase(this._repo);

  Future<BaseResponse<MyPlansModel>> call() {
    return _repo.getMyPlans();
  }
}
