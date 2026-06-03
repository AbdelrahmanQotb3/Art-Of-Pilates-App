import 'package:art_of_pilates/app/config/base_response/base_response.dart';
import 'package:art_of_pilates/app/features/bookings/domain/model/book_session_with_plan_model.dart';
import 'package:art_of_pilates/app/features/bookings/domain/repo/bookings_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable 
class BookSessionWithPlanUseCase {
  BookSessionWithPlanUseCase(this._repo);
  final BookingsRepoContract _repo;
  Future<BaseResponse<BookSessionWithPlanModel>> call(String sessionId, String userPlanId) => _repo.bookSessionWithPlan(sessionId , userPlanId);
}