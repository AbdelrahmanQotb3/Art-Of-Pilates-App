import 'package:art_of_pilates/app/config/base_response/base_response.dart';
import 'package:art_of_pilates/app/features/bookings/data/model/book_plan_response.dart';
import 'package:art_of_pilates/app/features/bookings/data/model/book_response.dart';
import 'package:art_of_pilates/app/features/bookings/data/model/bookings_response.dart';
import 'package:art_of_pilates/app/features/bookings/data/model/cancel_booking_response.dart';
import 'package:art_of_pilates/app/features/bookings/data/model/check_booking_response.dart';
import 'package:art_of_pilates/app/features/bookings/data/model/my_plans_response.dart';

abstract class BookingsDataSourceContract {
  Future<BaseResponse<BookingsResponse>> getAllBookings();
  Future<BaseResponse<CancelBookingResponse>> cancelBooking(String id);
  Future<BaseResponse<BookResponse>> bookSession(String sessionId, String? comment);
  Future<BaseResponse<CheckBookingResponse>> checkBooking(String sessionId);
  Future<BaseResponse<BookPlanResponse>> bookAllPlanSessions(String userPlanId);
  Future<BaseResponse<MyPlansResponse>> getMyPlans();
}
