import 'package:art_of_pilates/app/config/base_response/base_response.dart';
import 'package:art_of_pilates/app/features/bookings/domain/model/book_model.dart';
import 'package:art_of_pilates/app/features/bookings/domain/model/book_plan_model.dart';
import 'package:art_of_pilates/app/features/bookings/domain/model/bookings_model.dart';
import 'package:art_of_pilates/app/features/bookings/domain/model/cancel_booking_model.dart';
import 'package:art_of_pilates/app/features/bookings/domain/model/check_booking_model.dart';
import 'package:art_of_pilates/app/features/bookings/domain/model/my_plans_model.dart';

abstract class BookingsRepoContract {
  Future<BaseResponse<BookingsModel>> getAllBookings();
  Future<BaseResponse<CancelBookingModel>> cancelBooking(String id);
  Future<BaseResponse<BookModel>> bookSession(String sessionId , String? comment);
  Future<BaseResponse<CheckBookingModel>> checkBooking(String sessionId);
  Future<BaseResponse<BookPlanModel>> bookAllPlanSessions(String userPlanId);
  Future<BaseResponse<MyPlansModel>> getMyPlans();
}
