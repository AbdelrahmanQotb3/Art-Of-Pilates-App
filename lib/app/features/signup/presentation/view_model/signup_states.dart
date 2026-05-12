import 'package:art_of_pilates/app/config/base_state/base_state.dart';
import 'package:art_of_pilates/app/core/util/exceptions/abstract/app_exception.dart';
import 'package:art_of_pilates/app/features/signup/domain/model/signup_model.dart';

class SignupStates {
  BaseState<SignupModel>? signupState;
  AppException? appException;

  SignupStates({this.signupState , this.appException});

  SignupStates copyWith({BaseState<SignupModel>? signupStateParam, Object? appExceptionParam = _sentinel}) {
    return SignupStates(
      signupState: signupStateParam ?? signupState,
      appException: appExceptionParam == _sentinel
          ? appException
          : appExceptionParam as AppException?,
    );
  }

  static const _sentinel = Object();
}
