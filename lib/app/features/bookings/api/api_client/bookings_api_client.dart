import 'package:art_of_pilates/app/config/app_end_points.dart';
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
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'bookings_api_client.g.dart';

@RestApi(baseUrl: AppEndPoints.baseUrl)
@injectable
abstract class BookingsApiClient {
  @factoryMethod
  factory BookingsApiClient(Dio dio) = _BookingsApiClient;

  @GET(AppEndPoints.getAllBookings)
  Future<BookingsResponse> getAllBookings();

  @DELETE(AppEndPoints.cancelBooking)
  Future<CancelBookingResponse> cancelBooking(@Path('bookingId') String id);

  @POST(AppEndPoints.bookSessionDirectly)
  Future<BookResponse> bookSessionDirectly(@Body() Map<String, dynamic> body);

  @GET(AppEndPoints.checkBooking)
  Future<CheckBookingResponse> checkBooking(
    @Path('sessionId') String sessionId,
  );

  @POST(AppEndPoints.bookPlan)
  Future<BookPlanResponse> bookAllPlanSessions(
    @Body() Map<String, dynamic> body,
  );

  @GET(AppEndPoints.getMyPlans)
  Future<MyPlansResponse> getMyPlans();

  @POST(AppEndPoints.purchasePlan)
  Future<PurchasePlanResponse> purchasePlan(@Body() Map<String, dynamic> body);

  @POST(AppEndPoints.joinWaitingList)
  Future<JoinWaitingListResponse> joinWaitingList(
    @Body() Map<String, dynamic> body,
  );

  @GET(AppEndPoints.checkPlanForSession)
  Future<CheckPlanResponse> checkPlanForSession(
    @Path('sessionId') String sessionId,
  );

  @POST(AppEndPoints.bookWithPlan)
  Future<BookSessionWithPlanResponse> bookSessionWithPlan(@Body() Map<String, dynamic> body);

  @GET(AppEndPoints.getPlanSummery)
  Future<GetPlanSummeryResponse> getPlanSummery();
}
