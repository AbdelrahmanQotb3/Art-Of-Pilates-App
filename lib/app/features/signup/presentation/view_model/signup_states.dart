import 'package:art_of_pilates/app/config/base_state/base_state.dart';
import 'package:art_of_pilates/app/features/signup/domain/model/signup_model.dart';

class SignupStates {
  BaseState<SignupModel>? signupState;

  SignupStates({this.signupState});

  SignupStates copyWith({BaseState<SignupModel>? signupStateParam}) {
    return SignupStates(signupState: signupStateParam ?? signupState);
  }
}
