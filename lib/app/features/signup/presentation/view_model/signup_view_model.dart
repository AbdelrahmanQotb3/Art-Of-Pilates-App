import 'package:art_of_pilates/app/config/base_response/base_response.dart';
import 'package:art_of_pilates/app/config/base_state/base_state.dart';
import 'package:art_of_pilates/app/features/signup/domain/model/signup_model.dart';
import 'package:art_of_pilates/app/features/signup/domain/use_case/signup_use_case.dart';
import 'package:art_of_pilates/app/features/signup/presentation/view_model/signup_events.dart';
import 'package:art_of_pilates/app/features/signup/presentation/view_model/signup_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class SignupViewModel extends Cubit<SignupStates> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final SignupUseCase _signupUseCase;

  SignupViewModel(this._signupUseCase) : super(SignupStates());

  void doIntent(
    SignupEvents event,
    String firstName,
    String lastName,
    String email,
    String password,
  ) {
    switch (event) {
      case SignupEvent():
        signup(firstName, lastName, email, password);
    }
  }

  Future<void> signup(
    String firstName,
    String lastName,
    String email,
    String password,
  ) async {
    emit(
      state.copyWith(signupStateParam: BaseState<SignupModel>(isLoading: true)),
    );
    final result = await _signupUseCase(email, password, firstName, lastName);
    switch (result) {
      case SuccessResponse<SignupModel>():
        emit(
          state.copyWith(
            signupStateParam: BaseState<SignupModel>(
              data: result.data,
              isLoading: false,
            ),
          ),
        );
      case ErrorResponse(error: final error):
        emit(
          state.copyWith(
            signupStateParam: BaseState<SignupModel>(
              errorMessage: error.toString(),
              isLoading: false,
            ),
          ),
        );
    }
  }
}
