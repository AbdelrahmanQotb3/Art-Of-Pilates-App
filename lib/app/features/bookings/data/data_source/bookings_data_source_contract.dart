import 'package:art_of_pilates/app/config/base_response/base_response.dart';
import 'package:art_of_pilates/app/features/bookings/data/model/book_plan_response.dart';
import 'package:art_of_pilates/app/features/bookings/data/model/book_response.dart';
import 'package:art_of_pilates/app/features/bookings/data/model/book_session_with_plan_response.dart';
import 'package:art_of_pilates/app/features/bookings/data/model/bookings_response.dart';
import 'package:art_of_pilates/app/features/bookings/data/model/cancel_booking_response.dart';
import 'package:art_of_pilates/app/features/bookings/data/model/check_booking_response.dart';
import 'package:art_of_pilates/app/features/bookings/data/model/check_plan_response.dart';
import 'package:art_of_pilates/app/features/bookings/data/model/get_plan_summery_response.dart';
import 'package:art_of_pilates/app/features/bookings/data/model/join_waiting_list_response.dart';
import 'package:art_of_pilates/app/features/bookings/data/model/my_plans_response.dart';
import 'package:art_of_pilates/app/features/bookings/data/model/purchase_plan_response.dart';

abstract class BookingsDataSourceContract {
  Future<BaseResponse<BookingsResponse>> getAllBookings();
  Future<BaseResponse<CancelBookingResponse>> cancelBooking(String id);
  Future<BaseResponse<BookResponse>> bookSession(
    String sessionId,
    String? comment,
  );
  Future<BaseResponse<CheckBookingResponse>> checkBooking(String sessionId);
  Future<BaseResponse<BookPlanResponse>> bookAllPlanSessions(String userPlanId);
  Future<BaseResponse<MyPlansResponse>> getMyPlans();
  Future<BaseResponse<PurchasePlanResponse>> purchasePlan(
    int pricingPlanId,
    String? startDate,
  );

  Future<BaseResponse<JoinWaitingListResponse>> joinWaitingList(String sessionId);
  Future<BaseResponse<CheckPlanResponse>> checkPlanForSession(String sessionId);
  Future<BaseResponse<BookSessionWithPlanResponse>> bookSessionWithPlan(String sessionId, String userPlanId);
  Future<BaseResponse<GetPlanSummeryResponse>> getPlanSummery();
}
