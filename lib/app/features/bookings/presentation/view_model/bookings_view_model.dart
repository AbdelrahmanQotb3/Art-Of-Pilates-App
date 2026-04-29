import 'package:art_of_pilates/app/config/base_response/base_response.dart';
import 'package:art_of_pilates/app/config/base_state/base_state.dart';
import 'package:art_of_pilates/app/features/bookings/domain/model/book_model.dart';
import 'package:art_of_pilates/app/features/bookings/domain/model/bookings_model.dart';
import 'package:art_of_pilates/app/features/bookings/domain/model/cancel_booking_model.dart';
import 'package:art_of_pilates/app/features/bookings/domain/model/check_booking_model.dart';
import 'package:art_of_pilates/app/features/bookings/domain/use_cases/book_session_use_case.dart';
import 'package:art_of_pilates/app/features/bookings/domain/use_cases/cancel_booking_use_case.dart';
import 'package:art_of_pilates/app/features/bookings/domain/use_cases/check_booking_use_case.dart';
import 'package:art_of_pilates/app/features/bookings/domain/use_cases/get_all_bookings_use_case.dart';
import 'package:art_of_pilates/app/features/bookings/presentation/view_model/bookings_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class BookingsViewModel extends Cubit<BookingsStates> {
  final GetAllBookingsUseCase _getAllBookingsUseCase;
  final CancelBookingUseCase _cancelBookingUseCase;
  final BookSessionUseCase _bookSessionUseCase;
  final CheckBookingUseCase _checkBookingUseCase;
  BookingsViewModel(this._getAllBookingsUseCase, this._cancelBookingUseCase, this._bookSessionUseCase, this._checkBookingUseCase) : super(BookingsStates());

  Future<BaseResponse<BookingsModel>> getAllBookings() async{
    emit(state.copyWith(getAllBookingsState: BaseState<BookingsModel>(isLoading: true)));
    final response = await _getAllBookingsUseCase();
    switch( response){
      case SuccessResponse(data: final data):
        emit(state.copyWith(getAllBookingsState: BaseState<BookingsModel>(data: data, isLoading: false)));
        return SuccessResponse(data: data);
      case ErrorResponse(error: final error):
        emit(state.copyWith(getAllBookingsState: BaseState<BookingsModel>(errorMessage: error.toString(), isLoading: false)));
        return ErrorResponse(error: error);
    }
  }

  Future<BaseResponse<CancelBookingModel>> cancelBooking(String id) async {
    emit(state.copyWith(cancelBookingState: BaseState<CancelBookingModel>(isLoading: true)));
    final response = await _cancelBookingUseCase.call(id);
    switch( response){
      case SuccessResponse(data: final data):
        emit(state.copyWith(cancelBookingState: BaseState<CancelBookingModel>(data: data, isLoading: false)));
        return SuccessResponse(data: data);
      case ErrorResponse(error: final error):
        emit(state.copyWith(cancelBookingState: BaseState<CancelBookingModel>(errorMessage: error.toString(), isLoading: false)));
        return ErrorResponse(error: error);
    }
  }

  Future<BaseResponse<BookModel>> bookSession(String sessionId) async {
    emit(state.copyWith(bookSessionState: BaseState<BookModel>(isLoading: true)));
    final response = await _bookSessionUseCase.call(sessionId);
    switch( response){
      case SuccessResponse(data: final data):
        emit(state.copyWith(bookSessionState: BaseState<BookModel>(data: data, isLoading: false)));
        return SuccessResponse(data: data);
      case ErrorResponse(error: final error):
        emit(state.copyWith(bookSessionState: BaseState<BookModel>(errorMessage: error.toString(), isLoading: false)));
        return ErrorResponse(error: error);
    }
  }

  Future<BaseResponse<CheckBookingModel>> checkBooking(String sessionId) async {
    emit(state.copyWith(checkBookingState: BaseState<CheckBookingModel>(isLoading: true)));
    final response = await _checkBookingUseCase.call(sessionId);
    switch( response){
      case SuccessResponse(data: final data):
        emit(state.copyWith(checkBookingState: BaseState<CheckBookingModel>(data: data, isLoading: false)));
        return SuccessResponse(data: data);
      case ErrorResponse(error: final error):
        emit(state.copyWith(checkBookingState: BaseState<CheckBookingModel>(errorMessage: error.toString(), isLoading: false)));
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
}
