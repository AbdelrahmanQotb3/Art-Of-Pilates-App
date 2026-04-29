import 'package:art_of_pilates/app/config/app_end_points.dart';
import 'package:art_of_pilates/app/features/bookings/data/model/book_response.dart';
import 'package:art_of_pilates/app/features/bookings/data/model/bookings_response.dart';
import 'package:art_of_pilates/app/features/bookings/data/model/cancel_booking_response.dart';
import 'package:art_of_pilates/app/features/bookings/data/model/check_booking_response.dart';
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
  Future<CheckBookingResponse> checkBooking(@Path('sessionId') String sessionId);

}
