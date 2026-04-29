import 'package:art_of_pilates/app/config/base_response/base_response.dart';
import 'package:art_of_pilates/app/features/bookings/domain/model/book_model.dart';
import 'package:art_of_pilates/app/features/bookings/domain/repo/bookings_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class BookSessionUseCase {
  final BookingsRepoContract _bookingsRepo;

  BookSessionUseCase(this._bookingsRepo);

  Future<BaseResponse<BookModel>> call(String sessionId) async {
    return await _bookingsRepo.bookSession(sessionId);
  }
}