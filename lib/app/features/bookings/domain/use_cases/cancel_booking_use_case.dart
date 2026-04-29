import 'package:art_of_pilates/app/config/base_response/base_response.dart';
import 'package:art_of_pilates/app/features/bookings/domain/model/cancel_booking_model.dart';
import 'package:art_of_pilates/app/features/bookings/domain/repo/bookings_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class CancelBookingUseCase {
  final BookingsRepoContract bookingsRepo;
  CancelBookingUseCase(this.bookingsRepo);
  Future<BaseResponse<CancelBookingModel>> call(String id) async {
    return await bookingsRepo.cancelBooking(id);
  }
}