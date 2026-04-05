import 'package:art_of_pilates/app/config/base_state/base_state.dart';
import 'package:art_of_pilates/app/features/signin/domain/model/signin_model.dart';

class SigninStates {
  BaseState<SigninModel>? signinState;

  SigninStates({this.signinState});

  SigninStates copyWith({BaseState<SigninModel>? signinStateParam}) {
    return SigninStates(signinState: signinStateParam ?? signinState);
  }
}
