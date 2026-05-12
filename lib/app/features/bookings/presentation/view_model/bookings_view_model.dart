import 'package:art_of_pilates/app/config/base_response/base_response.dart';
import 'package:art_of_pilates/app/config/base_state/base_state.dart';
import 'package:art_of_pilates/app/core/util/exceptions/abstract/app_exception.dart';
import 'package:art_of_pilates/app/core/util/exceptions/bookings/book_exception.dart';
import 'package:art_of_pilates/app/core/util/exceptions/bookings/cancle_booking_exception.dart';
import 'package:art_of_pilates/app/features/bookings/domain/model/book_model.dart';
import 'package:art_of_pilates/app/features/bookings/domain/model/book_plan_model.dart';
import 'package:art_of_pilates/app/features/bookings/domain/model/bookings_model.dart';
import 'package:art_of_pilates/app/features/bookings/domain/model/cancel_booking_model.dart';
import 'package:art_of_pilates/app/features/bookings/domain/model/check_booking_model.dart';
import 'package:art_of_pilates/app/features/bookings/domain/model/my_plans_model.dart';
import 'package:art_of_pilates/app/features/bookings/domain/use_cases/book_plan_use_case.dart';
import 'package:art_of_pilates/app/features/bookings/domain/use_cases/book_session_use_case.dart';
import 'package:art_of_pilates/app/features/bookings/domain/use_cases/cancel_booking_use_case.dart';
import 'package:art_of_pilates/app/features/bookings/domain/use_cases/check_booking_use_case.dart';
import 'package:art_of_pilates/app/features/bookings/domain/use_cases/get_all_bookings_use_case.dart';
import 'package:art_of_pilates/app/features/bookings/domain/use_cases/get_my_plans_use_case.dart';
import 'package:art_of_pilates/app/features/bookings/presentation/view_model/bookings_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@singleton
class BookingsViewModel extends Cubit<BookingsStates> {
  final GetAllBookingsUseCase _getAllBookingsUseCase;
  final CancelBookingUseCase _cancelBookingUseCase;
  final BookSessionUseCase _bookSessionUseCase;
  final CheckBookingUseCase _checkBookingUseCase;
  final BookPlanUseCase _bookPlanUseCase;
  final GetMyPlansUseCase _getMyPlansUseCase;
  final TextEditingController commentController = TextEditingController();

  BookingsViewModel(
    this._getAllBookingsUseCase,
    this._cancelBookingUseCase,
    this._bookSessionUseCase,
    this._checkBookingUseCase,
    this._bookPlanUseCase,
    this._getMyPlansUseCase,
  ) : super(BookingsStates());

  AppException _normalizeException(Exception error, AppException fallback) {
    return error is AppException ? error : fallback;
  }

  Future<BaseResponse<BookingsModel>> getAllBookings() async {
    emit(
      state.copyWith(
        getAllBookingsState: BaseState<BookingsModel>(isLoading: true),
        appExceptionParam: null,
      ),
    );
    final response = await _getAllBookingsUseCase();
    switch (response) {
      case SuccessResponse(data: final data):
        emit(
          state.copyWith(
            getAllBookingsState: BaseState<BookingsModel>(
              data: data,
              isLoading: false,
            ),
            appExceptionParam: null,
          ),
        );
        return SuccessResponse(data: data);
      case ErrorResponse(error: final error):
        emit(
          state.copyWith(
            getAllBookingsState: BaseState<BookingsModel>(
              errorMessage: error.toString(),
              isLoading: false,
            ),
            appExceptionParam: _normalizeException(
              error,
              BookException(error: error.toString()),
            ),
          ),
        );
        return ErrorResponse(error: error);
    }
  }

  Future<BaseResponse<CancelBookingModel>> cancelBooking(String id) async {
    emit(
      state.copyWith(
        cancelBookingState: BaseState<CancelBookingModel>(isLoading: true),
        appExceptionParam: null,
      ),
    );
    final response = await _cancelBookingUseCase.call(id);
    switch (response) {
      case SuccessResponse(data: final data):
        emit(
          state.copyWith(
            cancelBookingState: BaseState<CancelBookingModel>(
              data: data,
              isLoading: false,
            ),
            appExceptionParam: null,
          ),
        );
        return SuccessResponse(data: data);
      case ErrorResponse(error: final error):
        final appException = _normalizeException(
          error,
          CancleBookingException(error: error.toString()),
        );
        emit(
          state.copyWith(
            cancelBookingState: BaseState<CancelBookingModel>(
              errorMessage: appException.createErrorMessage(),
              isLoading: false,
            ),
            appExceptionParam: appException,
          ),
        );
        return ErrorResponse(error: error);
    }
  }

  Future<BaseResponse<BookModel>> bookSession(String sessionId) async {
    emit(
      state.copyWith(
        bookSessionState: BaseState<BookModel>(isLoading: true),
        appExceptionParam: null,
      ),
    );
    final response = await _bookSessionUseCase.call(
      sessionId,
      commentController.text.isEmpty ? null : commentController.text,
    );
    switch (response) {
      case SuccessResponse(data: final data):
        emit(
          state.copyWith(
            bookSessionState: BaseState<BookModel>(
              data: data,
              isLoading: false,
            ),
            appExceptionParam: null,
          ),
        );
        return SuccessResponse(data: data);
      case ErrorResponse(error: final error):
        final appException = _normalizeException(
          error,
          BookException(error: error.toString()),
        );
        emit(
          state.copyWith(
            bookSessionState: BaseState<BookModel>(
              errorMessage: appException.createErrorMessage(),
              isLoading: false,
            ),
            appExceptionParam: appException,
          ),
        );
        return ErrorResponse(error: error);
    }
  }

  Future<BaseResponse<CheckBookingModel>> checkBooking(String sessionId) async {
    emit(
      state.copyWith(
        checkBookingState: BaseState<CheckBookingModel>(isLoading: true),
        appExceptionParam: null,
      ),
    );
    final response = await _checkBookingUseCase.call(sessionId);
    switch (response) {
      case SuccessResponse(data: final data):
        emit(
          state.copyWith(
            checkBookingState: BaseState<CheckBookingModel>(
              data: data,
              isLoading: false,
            ),
            appExceptionParam: null,
          ),
        );
        return SuccessResponse(data: data);
      case ErrorResponse(error: final error):
        emit(
          state.copyWith(
            checkBookingState: BaseState<CheckBookingModel>(
              errorMessage: error.toString(),
              isLoading: false,
            ),
            appExceptionParam: _normalizeException(
              error,
              BookException(error: error.toString()),
            ),
          ),
        );
        return ErrorResponse(error: error);
    }
  }

  Future<void> checkAllSessions(List<String> sessionIds) async {
    final results = await Future.wait(
      sessionIds.map((id) => _checkBookingUseCase.call(id)),
    );

    final Map<String, bool> map = {};
    for (int i = 0; i < sessionIds.length; i++) {
      final response = results[i];
      switch (response) {
        case SuccessResponse(data: final data):
          map[sessionIds[i]] = data.isBooked ?? false;
        case ErrorResponse():
          map[sessionIds[i]] = false;
      }
    }
    
    emit(state.copyWith(checkedSessions: map));
  }

  Future<BaseResponse<BookPlanModel>> bookPlan(String userPlanId) async {
    emit(
      state.copyWith(
        bookPlanState: BaseState<BookPlanModel>(isLoading: true),
        appExceptionParam: null,
      ),
    );
    final response = await _bookPlanUseCase.call(userPlanId);
    switch (response) {
      case SuccessResponse(data: final data):
        emit(
          state.copyWith(
            bookPlanState: BaseState<BookPlanModel>(
              data: data,
              isLoading: false,
            ),
            appExceptionParam: null,
          ),
        );
        return SuccessResponse(data: data);
      case ErrorResponse(error: final error):
        final appException = _normalizeException(
          error,
          BookException(error: error.toString()),
        );
        emit(
          state.copyWith(
            bookPlanState: BaseState<BookPlanModel>(
              errorMessage: appException.createErrorMessage(),
              isLoading: false,
            ),
            appExceptionParam: appException,
          ),
        );
        return ErrorResponse(error: error);
    }
  }

  Future<BaseResponse<MyPlansModel>> getMyPlans() async {
    emit(
      state.copyWith(
        getMyPlansState: BaseState<MyPlansModel>(isLoading: true),
        appExceptionParam: null,
      ),
    );
    final response = await _getMyPlansUseCase.call();
    switch (response) {
      case SuccessResponse(data: final data):
        emit(
          state.copyWith(
            getMyPlansState: BaseState<MyPlansModel>(
              data: data,
              isLoading: false,
            ),
            appExceptionParam: null,
          ),
        );
        return SuccessResponse(data: data);
      case ErrorResponse(error: final error):
        final appException = _normalizeException(
          error,
          BookException(error: error.toString()),
        );
        emit(
          state.copyWith(
            getMyPlansState: BaseState<MyPlansModel>(
              errorMessage: appException.createErrorMessage(),
              isLoading: false,
            ),
            appExceptionParam: appException,
          ),
        );
        return ErrorResponse(error: error);
    }
  }
}
