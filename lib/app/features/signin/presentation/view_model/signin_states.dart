import 'package:art_of_pilates/app/config/base_state/base_state.dart';
import 'package:art_of_pilates/app/core/util/exceptions/abstract/app_exception.dart';
import 'package:art_of_pilates/app/features/signin/domain/model/signin_model.dart';

class SigninStates {
  final BaseState<SigninModel>? signinState;
  final AppException? appException;

  SigninStates({this.signinState, this.appException});

  SigninStates copyWith({
    BaseState<SigninModel>? signinStateParam,
    Object? appExceptionParam = _sentinel,
  }) {
    return SigninStates(
      signinState: signinStateParam ?? signinState,
      appException: appExceptionParam == _sentinel
          ? appException
          : appExceptionParam as AppException?,
    );
  }
}

const _sentinel = Object();