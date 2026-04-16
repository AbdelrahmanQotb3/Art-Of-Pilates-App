import 'package:art_of_pilates/app/config/base_response/base_response.dart';
import 'package:art_of_pilates/app/config/base_state/base_state.dart';
import 'package:art_of_pilates/app/features/schedule-sessions/domain/model/sessions_model.dart';
import 'package:art_of_pilates/app/features/schedule-sessions/domain/use_cases/get_all_sessions_use_case.dart';
import 'package:art_of_pilates/app/features/schedule-sessions/domain/use_cases/get_one_session_use_case.dart';
import 'package:art_of_pilates/app/features/schedule-sessions/presentation/view_model/sessions_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';


@injectable
class SessionsViewModel extends Cubit<SessionsStates> {
  final GetAllSessionsUseCase getAllSessionsUseCase;
  final GetOneSessionUseCase getOneSessionUseCase;
  SessionsViewModel(this.getAllSessionsUseCase , this.getOneSessionUseCase) : super(SessionsStates());

  Future<BaseResponse<SessionsModel>> getAllSessions() async{
    emit(state.copyWith(getAllSessionsStateParams: BaseState<SessionsModel>(isLoading: true)));
    final response = await getAllSessionsUseCase.call();
    switch (response) {
      case SuccessResponse<SessionsModel>():
        emit(state.copyWith(getAllSessionsStateParams: BaseState<SessionsModel>(data: response.data, isLoading: false)));
        return response;
      case ErrorResponse<SessionsModel>():
        emit(state.copyWith(getAllSessionsStateParams: BaseState<SessionsModel>(errorMessage: response.error.toString(), isLoading: false)));
        return response;
    }
  }

  Future<BaseResponse<SessionEntity>> getOneSession(String id) async{
    emit(state.copyWith(getOneSessionStateParams: BaseState<SessionEntity>(isLoading: true)));
    final response = await getOneSessionUseCase.call(id);
    switch (response) {
      case SuccessResponse<SessionEntity>():
        emit(state.copyWith(getOneSessionStateParams: BaseState<SessionEntity>(data: response.data, isLoading: false)));
        return response;
      case ErrorResponse<SessionEntity>():
        emit(state.copyWith(getOneSessionStateParams: BaseState<SessionEntity>(errorMessage: response.error.toString(), isLoading: false)));
        return response;
    }
  }
}