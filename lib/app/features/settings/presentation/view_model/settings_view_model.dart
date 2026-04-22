import 'package:art_of_pilates/app/config/base_response/base_response.dart';
import 'package:art_of_pilates/app/config/base_state/base_state.dart';
import 'package:art_of_pilates/app/core/util/session_manager.dart';
import 'package:art_of_pilates/app/features/settings/domain/model/delete_account_model.dart';
import 'package:art_of_pilates/app/features/settings/domain/model/logout_model.dart';
import 'package:art_of_pilates/app/features/settings/domain/use_cases/delete_accoount_use_case.dart';
import 'package:art_of_pilates/app/features/settings/domain/use_cases/logout_use_case.dart';
import 'package:art_of_pilates/app/features/settings/domain/use_cases/navigate_to_signin_screen_use_case.dart';
import 'package:art_of_pilates/app/features/settings/presentation/view_model/settings_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class SettingsViewModel extends Cubit<SettingsStates> {
  final LogoutUseCase logoutUseCase;
  final SessionManager sessionManager = SessionManager();
  final DeleteAccoountUseCase deleteAccoountUseCase;

  SettingsViewModel(this.logoutUseCase , this.deleteAccoountUseCase) : super(SettingsStates());

  void logout(BuildContext context) async {
    emit(state.copyWith(logoutState: BaseState<LogoutModel>(isLoading: true)));

    final response = await logoutUseCase.call();

    switch (response) {
      case SuccessResponse<LogoutModel>():
        await sessionManager.clearSession();
        emit(
          state.copyWith(
            logoutState: BaseState<LogoutModel>(
              data: response.data,
              isLoading: false,
            ),
          ),
        );
        if (!context.mounted) return;
        NavigateToSigninScreenUseCase.call(context);
      case ErrorResponse<LogoutModel>():
        emit(
          state.copyWith(
            logoutState: BaseState<LogoutModel>(
              errorMessage: response.error.toString(),
              isLoading: false,
            ),
          ),
        );
    }
  }

  Future<bool> deleteAccount() async {
    emit(state.copyWith(deleteAccountState: BaseState<DeleteAccountModel>(isLoading: true)));
    final response = await deleteAccoountUseCase.call();
    switch (response) {
      case SuccessResponse<bool>():
        emit(state.copyWith(deleteAccountState: BaseState<DeleteAccountModel>(isLoading: false)));
        return true;
      case ErrorResponse<bool>():
        emit(state.copyWith(deleteAccountState: BaseState<DeleteAccountModel>(errorMessage: response.error.toString(), isLoading: false)));
        return false;
    }
  }
}
