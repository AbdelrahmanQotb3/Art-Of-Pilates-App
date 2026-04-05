import 'package:art_of_pilates/app/config/base_response/base_response.dart';
import 'package:art_of_pilates/app/config/base_state/base_state.dart';
import 'package:art_of_pilates/app/features/signin/domain/model/signin_model.dart';
import 'package:art_of_pilates/app/features/signin/domain/use_cases/signin_use_case.dart';
import 'package:art_of_pilates/app/features/signin/presentation/view_model/signin_events.dart';
import 'package:art_of_pilates/app/features/signin/presentation/view_model/signin_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class SigninViewModel extends Cubit<SigninStates> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final SigninUseCase _signinUseCase;

  SigninViewModel(this._signinUseCase) : super(SigninStates());

  void doIntent(SigninEvents event, String email, String password) {
    switch (event) {
      case SigninEvent():
        signin(email, password);
    }
  }

  Future<void> signin(String email, String password) async {
    emit(
      state.copyWith(signinStateParam: BaseState<SigninModel>(isLoading: true)),
    );
    final result = await _signinUseCase.signin(email, password);
    switch (result) {
      case SuccessResponse<SigninModel>():
        emit(
          state.copyWith(
            signinStateParam: BaseState<SigninModel>(
              data: result.data,
              isLoading: false,
            ),
          ),
        );
      case ErrorResponse(error: final error):
        emit(
          state.copyWith(
            signinStateParam: BaseState<SigninModel>(
              errorMessage: error.toString(),
              isLoading: false,
            ),
          ),
        );
    }
  }
}
