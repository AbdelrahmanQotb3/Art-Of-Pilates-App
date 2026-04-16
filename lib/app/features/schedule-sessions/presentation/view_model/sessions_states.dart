import 'package:art_of_pilates/app/config/base_state/base_state.dart';
import 'package:art_of_pilates/app/features/schedule-sessions/domain/model/sessions_model.dart';

class SessionsStates {
  BaseState<SessionsModel>? getAllSessionsStateParams;
  BaseState<SessionEntity>? getOneSessionStateParams;

  SessionsStates({
    this.getAllSessionsStateParams,
    this.getOneSessionStateParams,
  });

  SessionsStates copyWith({
    BaseState<SessionsModel>? getAllSessionsStateParams,
    BaseState<SessionEntity>? getOneSessionStateParams,
  }) => SessionsStates(
    getAllSessionsStateParams:
        getAllSessionsStateParams ?? this.getAllSessionsStateParams,
    getOneSessionStateParams:
        getOneSessionStateParams ?? this.getOneSessionStateParams,
  );
}
