import 'package:art_of_pilates/app/config/base_response/base_response.dart';
import 'package:art_of_pilates/app/features/bookings/domain/model/book_plan_model.dart';
import 'package:art_of_pilates/app/features/bookings/domain/repo/bookings_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class BookPlanUseCase {
  final BookingsRepoContract _repo;

  BookPlanUseCase(this._repo);

  Future<BaseResponse<BookPlanModel>> call(String userPlanId) {
    return _repo.bookAllPlanSessions(userPlanId);
  }
}