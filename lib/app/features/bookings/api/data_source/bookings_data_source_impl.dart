import 'package:art_of_pilates/app/config/base_response/base_response.dart';
import 'package:art_of_pilates/app/features/bookings/api/api_client/bookings_api_client.dart';
import 'package:art_of_pilates/app/features/bookings/data/data_source/bookings_data_source_contract.dart';
import 'package:art_of_pilates/app/features/bookings/data/model/book_response.dart';
import 'package:art_of_pilates/app/features/bookings/data/model/bookings_response.dart';
import 'package:art_of_pilates/app/features/bookings/data/model/cancel_booking_response.dart';
import 'package:art_of_pilates/app/features/bookings/data/model/check_booking_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: BookingsDataSourceContract)
class BookingsDataSourceImpl implements BookingsDataSourceContract {
  final BookingsApiClient _bookingsApiClient;

  BookingsDataSourceImpl(this._bookingsApiClient);

  @override
  Future<BaseResponse<BookingsResponse>> getAllBookings() async {
    try {
      final response = await _bookingsApiClient.getAllBookings();
      return SuccessResponse(data: response);
    } on Exception catch (e) {
      return ErrorResponse(error: e);
    }
  }

  @override
  Future<BaseResponse<CancelBookingResponse>> cancelBooking(String id) async {
    try {
      final response = await _bookingsApiClient.cancelBooking(id);
      return SuccessResponse(data: response);
    } on Exception catch (e) {
      return ErrorResponse(error: e);
    }
  }

  @override
  Future<BaseResponse<BookResponse>> bookSession(String sessionId) async {
    try {
      final response = await _bookingsApiClient.bookSessionDirectly({
        'sessionId': sessionId,
      });
      return SuccessResponse(data: response);
    } on Exception catch (e) {
      return ErrorResponse(error: e);
    }
  }

  @override
  Future<BaseResponse<CheckBookingResponse>> checkBooking(String sessionId) async {
    try {
      final response = await _bookingsApiClient.checkBooking(sessionId);
      return SuccessResponse(data: response);
    } on Exception catch (e) {
      return ErrorResponse(error: e);
    }
  }
}
