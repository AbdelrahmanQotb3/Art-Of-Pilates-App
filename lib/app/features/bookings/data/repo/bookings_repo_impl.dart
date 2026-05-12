import 'package:art_of_pilates/app/config/base_response/base_response.dart';
import 'package:art_of_pilates/app/features/bookings/data/data_source/bookings_data_source_contract.dart';
import 'package:art_of_pilates/app/features/bookings/data/model/book_plan_response.dart';
import 'package:art_of_pilates/app/features/bookings/data/model/book_response.dart';
import 'package:art_of_pilates/app/features/bookings/data/model/bookings_response.dart';
import 'package:art_of_pilates/app/features/bookings/data/model/cancel_booking_response.dart';
import 'package:art_of_pilates/app/features/bookings/data/model/check_booking_response.dart';
import 'package:art_of_pilates/app/features/bookings/data/model/my_plans_response.dart';
import 'package:art_of_pilates/app/features/bookings/domain/model/book_model.dart';
import 'package:art_of_pilates/app/features/bookings/domain/model/book_plan_model.dart';
import 'package:art_of_pilates/app/features/bookings/domain/model/bookings_model.dart';
import 'package:art_of_pilates/app/features/bookings/domain/model/cancel_booking_model.dart';
import 'package:art_of_pilates/app/features/bookings/domain/model/check_booking_model.dart';
import 'package:art_of_pilates/app/features/bookings/domain/model/my_plans_model.dart';
import 'package:art_of_pilates/app/features/bookings/domain/repo/bookings_repo_contract.dart';
import 'package:art_of_pilates/app/features/schedule-sessions/data/model/sessions_response.dart';
import 'package:art_of_pilates/app/features/schedule-sessions/domain/model/sessions_model.dart';
import 'package:art_of_pilates/app/features/services/domain/model/services_model.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: BookingsRepoContract)
class BookingsRepoImpl implements BookingsRepoContract {
  final BookingsDataSourceContract _bookingsDataSource;

  BookingsRepoImpl(this._bookingsDataSource);

  @override
  Future<BaseResponse<BookingsModel>> getAllBookings() async {
    final response = await _bookingsDataSource.getAllBookings();
    return _mapToDomain(response);
  }

  BaseResponse<BookingsModel> _mapToDomain(
    BaseResponse<BookingsResponse> response,
  ) {
    if (response is SuccessResponse<BookingsResponse>) {
      return SuccessResponse(
        data: BookingsModel(
          message: response.data.message ?? '',
          bookings:
              response.data.bookings?.map(_mapBookingToEntity).toList() ?? [],
        ),
      );
    } else {
      return ErrorResponse(error: (response as ErrorResponse).error);
    }
  }

  BookingEntity _mapBookingToEntity(Bookings booking) {
    return BookingEntity(
      id: booking.id ?? '',
      userId: booking.userId ?? 0,
      sessionId: booking.sessionId ?? '',
      userPlanId: booking.userPlanId ?? '',
      createdAt: DateTime.tryParse(booking.createdAt ?? '') ?? DateTime.now(),
      session: booking.session != null
          ? _mapSessionToEntity(booking.session!)
          : null,
      userPlan: booking.userPlan != null
          ? _mapUserPlanToEntity(booking.userPlan!)
          : null,
    );
  }

  SessionEntity _mapSessionToEntity(Sessions session) {
    return SessionEntity(
      id: session.id,
      name: session.name,
      startTime: session.startTime,
      endTime: session.endTime,
      status: session.status,
      maxParticipants: session.maxParticipants,
      currentParticipants: session.currentParticipants,
      serviceId: session.serviceId,
      staffMemberId: session.staffMemberId,
      service: session.service != null
          ? ServiceEntity(
              name: session.service!.name,
              location: session.service!.location,
            )
          : null,
      staffMember: session.staffMember != null
          ? StaffMemberEntity(
              name: session.staffMember!.name,
              email: session.staffMember!.email,
            )
          : null,
    );
  }

  UserPlanEntity _mapUserPlanToEntity(UserPlan userPlan) {
    return UserPlanEntity(
      id: userPlan.id ?? '',
      sessionsTotal: userPlan.sessionsTotal ?? 0,
      sessionsUsed: userPlan.sessionsUsed ?? 0,
      sessionsLeft: userPlan.sessionsLeft ?? 0,
      status: userPlan.status ?? '',
      expiryDate: userPlan.expiryDate != null
          ? DateTime.tryParse(userPlan.expiryDate!)
          : null,
      planName: userPlan.pricingPlan?.planName ?? '',
    );
  }

  UserPlanEntity _mapMyPlansUserPlanToEntity(Plans userPlan) {
    return UserPlanEntity(
      id: userPlan.id?.toString() ?? '',
      sessionsTotal: userPlan.sessionsTotal ?? 0,
      sessionsUsed: userPlan.sessionsUsed ?? 0,
      sessionsLeft: userPlan.sessionsLeft ?? 0,
      status: userPlan.status ?? '',
      expiryDate: null,
      planName: userPlan.pricingPlan?.planName ?? '',
    );
  }

  @override
  Future<BaseResponse<CancelBookingModel>> cancelBooking(String id) async {
    final response = await _bookingsDataSource.cancelBooking(id);
    switch (response) {
      case SuccessResponse<CancelBookingResponse>():
        final CancelBookingModel model = CancelBookingModel(
          message: response.data.message ?? '',
          cancelled: response.data.cancelled ?? false,
        );
        return SuccessResponse(data: model);
      case ErrorResponse():
        return ErrorResponse(error: response.error);
    }
  }

  @override
  Future<BaseResponse<BookModel>> bookSession(String sessionId , String? comment) async {
    final response = await _bookingsDataSource.bookSession(sessionId, comment);
    switch (response) {
      case SuccessResponse<BookResponse>():
        final BookModel model = BookModel(
          id: response.data.invoice?.id,
          userId: response.data.invoice?.userId,
          sessionId: response.data.invoice?.sessionId,
          userPlanId: response.data.invoice?.userPlanId,
          createdAt: response.data.invoice?.createdAt != null
              ? DateTime.tryParse(response.data.invoice!.createdAt!)
              : null,
          invoiceId: response.data.invoice?.id,
        );
        return SuccessResponse(data: model);
      case ErrorResponse():
        return ErrorResponse(error: response.error);
    }
  }

  @override
  Future<BaseResponse<CheckBookingModel>> checkBooking(String sessionId) async {
    final response = await _bookingsDataSource.checkBooking(sessionId);
    switch (response) {
      case SuccessResponse<CheckBookingResponse>():
        final CheckBookingModel model = CheckBookingModel(
          isBooked: response.data.isBooked,
          invoiceId: response.data.invoiceId,
        );
        return SuccessResponse(data: model);
      case ErrorResponse():
        return ErrorResponse(error: response.error);
    }
  }

  @override
  Future<BaseResponse<BookPlanModel>> bookAllPlanSessions(
    String userPlanId,
  ) async {
    final response = await _bookingsDataSource.bookAllPlanSessions(userPlanId);
    switch (response) {
      case SuccessResponse<BookPlanResponse>():
        return SuccessResponse(
          data: BookPlanModel(
            message: response.data.message,
            bookedCount: response.data.bookedCount,
            sessionsLeft: response.data.sessionsLeft,
          ),
        );
      case ErrorResponse():
        return ErrorResponse(error: response.error);
    }
  }

  @override
  Future<BaseResponse<MyPlansModel>> getMyPlans() async {
    final response = await _bookingsDataSource.getMyPlans();
    switch (response) {
      case SuccessResponse<MyPlansResponse>():
        return SuccessResponse(
          data: MyPlansModel(
            message: response.data.message,
            plans: response.data.plans
                ?.map(_mapMyPlansUserPlanToEntity)
                .toList(),
          ),
        );
      case ErrorResponse():
        return ErrorResponse(error: response.error);
    }
  }
}
