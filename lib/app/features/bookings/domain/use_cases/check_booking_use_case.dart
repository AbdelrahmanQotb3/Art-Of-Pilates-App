import 'package:art_of_pilates/app/config/base_response/base_response.dart';
import 'package:art_of_pilates/app/features/bookings/domain/model/check_booking_model.dart';
import 'package:art_of_pilates/app/features/bookings/domain/repo/bookings_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class CheckBookingUseCase {
  final BookingsRepoContract _bookingsRepo;

  CheckBookingUseCase(this._bookingsRepo);

  Future<BaseResponse<CheckBookingModel>> call(String sessionId) async {
    return await _bookingsRepo.checkBooking(sessionId);
  }
}