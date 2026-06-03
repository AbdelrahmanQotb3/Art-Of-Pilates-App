import 'package:art_of_pilates/app/config/base_state/base_state.dart';
import 'package:art_of_pilates/app/core/util/exceptions/abstract/app_exception.dart';
import 'package:art_of_pilates/app/features/bookings/domain/model/book_model.dart';
import 'package:art_of_pilates/app/features/bookings/domain/model/book_plan_model.dart';
import 'package:art_of_pilates/app/features/bookings/domain/model/book_session_with_plan_model.dart';
import 'package:art_of_pilates/app/features/bookings/domain/model/bookings_model.dart';
import 'package:art_of_pilates/app/features/bookings/domain/model/cancel_booking_model.dart';
import 'package:art_of_pilates/app/features/bookings/domain/model/check_booking_model.dart';
import 'package:art_of_pilates/app/features/bookings/domain/model/check_plan_model.dart';
import 'package:art_of_pilates/app/features/bookings/domain/model/join_waiting_list_model.dart';
import 'package:art_of_pilates/app/features/bookings/domain/model/my_plan_summery_model.dart';
import 'package:art_of_pilates/app/features/bookings/domain/model/my_plans_model.dart';
import 'package:art_of_pilates/app/features/bookings/domain/model/purchase_plan_model.dart';

class BookingsStates {
  BaseState<BookingsModel>? getAllBookingsState;
  BaseState<CancelBookingModel>? cancelBookingState;
  BaseState<BookModel>? bookSessionState;
  BaseState<CheckBookingModel>? checkBookingState;
  final Map<String, bool> checkedSessions;
  BaseState<BookPlanModel>? bookPlanState;
  BaseState<MyPlansModel>? getMyPlansState;
  AppException? appException;
  BaseState<PurchasePlanModel>? purchasePlanState;
  BaseState<JoinWaitingListModel>? joinWaitingListState;
  BaseState<CheckPlanModel>? checkPlanState;
  BaseState<BookSessionWithPlanModel>? bookSessionWithPlanState;
  BaseState<MyPlanSummeryModel>? getPlanSummeryState; 

  BookingsStates({
    this.getAllBookingsState,
    this.cancelBookingState,
    this.bookSessionState,
    this.checkBookingState,
    this.checkedSessions = const {},
    this.bookPlanState,
    this.getMyPlansState,
    this.appException,
    this.purchasePlanState,
    this.joinWaitingListState,
    this.checkPlanState,
    this.bookSessionWithPlanState,
    this.getPlanSummeryState
  });

  BookingsStates copyWith({
    BaseState<BookingsModel>? getAllBookingsState,
    BaseState<CancelBookingModel>? cancelBookingState,
    BaseState<BookModel>? bookSessionState,
    BaseState<CheckBookingModel>? checkBookingState,
    Map<String, bool>? checkedSessions,
    BaseState<BookPlanModel>? bookPlanState,
    BaseState<MyPlansModel>? getMyPlansState,
    Object? appExceptionParam = _sentinel,
    BaseState<PurchasePlanModel>? purchasePlanState,
    BaseState<JoinWaitingListModel>? joinWaitingListState,
    BaseState<CheckPlanModel>? checkPlanState,
    BaseState<BookSessionWithPlanModel>? bookSessionWithPlanState,
    BaseState<MyPlanSummeryModel>? getPlanSummeryState,
  }) {
    return BookingsStates(
      getAllBookingsState: getAllBookingsState ?? this.getAllBookingsState,
      cancelBookingState: cancelBookingState ?? this.cancelBookingState,
      bookSessionState: bookSessionState ?? this.bookSessionState,
      checkBookingState: checkBookingState ?? this.checkBookingState,
      checkedSessions: checkedSessions ?? this.checkedSessions,
      bookPlanState: bookPlanState ?? this.bookPlanState,
      getMyPlansState: getMyPlansState ?? this.getMyPlansState,
      appException: appExceptionParam == _sentinel
          ? appException
          : appExceptionParam as AppException?,
      purchasePlanState: purchasePlanState ?? this.purchasePlanState,
      joinWaitingListState: joinWaitingListState ?? this.joinWaitingListState,
      checkPlanState: checkPlanState ?? this.checkPlanState,
      bookSessionWithPlanState: bookSessionWithPlanState ?? this.bookSessionWithPlanState,
      getPlanSummeryState: getPlanSummeryState ?? this.getPlanSummeryState
    );
  }

  static const _sentinel = Object();
}
