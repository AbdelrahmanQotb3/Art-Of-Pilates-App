import 'package:art_of_pilates/app/config/base_response/base_response.dart';
import 'package:art_of_pilates/app/features/bookings/domain/model/bookings_model.dart';
import 'package:art_of_pilates/app/features/bookings/domain/repo/bookings_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAllBookingsUseCase {
  final BookingsRepoContract _bookingsRepoContract;
  GetAllBookingsUseCase(this._bookingsRepoContract);

  Future<BaseResponse<BookingsModel>> call() async {
    return await _bookingsRepoContract.getAllBookings();
  }
}
