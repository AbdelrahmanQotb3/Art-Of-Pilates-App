import 'package:art_of_pilates/app/config/base_state/base_state.dart';
import 'package:art_of_pilates/app/features/settings/domain/model/delete_account_model.dart';
import 'package:art_of_pilates/app/features/settings/domain/model/logout_model.dart';

class SettingsStates {
  BaseState<LogoutModel>? logoutState;
  BaseState<DeleteAccountModel>? deleteAccountState;

  SettingsStates({this.logoutState , this.deleteAccountState});

  SettingsStates copyWith({BaseState<LogoutModel>? logoutState , BaseState<DeleteAccountModel>? deleteAccountState}) {
    return SettingsStates(logoutState: logoutState ?? this.logoutState , deleteAccountState: deleteAccountState ?? this.deleteAccountState);
  }
}