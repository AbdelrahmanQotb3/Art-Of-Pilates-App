import 'package:art_of_pilates/app/config/base_response/base_response.dart';
import 'package:art_of_pilates/app/config/base_state/base_state.dart';
import 'package:art_of_pilates/app/core/util/exceptions/abstract/app_exception.dart';
import 'package:art_of_pilates/app/features/signin/domain/model/signin_model.dart';
import 'package:art_of_pilates/app/features/signin/domain/use_cases/signin_use_case.dart';
import 'package:art_of_pilates/app/features/signin/presentation/view_model/signin_events.dart';
import 'package:art_of_pilates/app/features/signin/presentation/view_model/signin_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

@injectable
class SigninViewModel extends Cubit<SigninStates> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final SigninUseCase _signinUseCase;

  final GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: ['email', 'profile'],
  serverClientId: '147658495150-blnq1kduep76t8vcrtsfn8lq6qi5k0d9.apps.googleusercontent.com'
);

  SigninViewModel(this._signinUseCase) : super(SigninStates());

  void doIntent(SigninEvents event, [String? email, String? password]) {
    if (event is SigninEvent) {
      signin(email!, password!);
    } else if (event is SigninWithGoogleEvent) {
      _signinWithGoogle();
    } else if (event is SigninWithAppleEvent) {
      _signinWithApple();
    }
  }

  Future<void> signin(String email, String password) async {
    _emitLoading();
    final result = await _signinUseCase.signin(email, password);
    _handleResult(result);
  }

  Future<void> _signinWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return;
      final auth = await googleUser.authentication;
      if (auth.idToken == null) {
        _emitError(
          "Google did not provide an ID Token. Please verify your SHA-1 fingerprint in Firebase.",
        );
        return;
      }
      _emitLoading();
      final result = await _signinUseCase.signinWithGoogle(
        auth.idToken!,
      );
      _handleResult(result);
    } catch (e) {
      _emitError("Google Sign-In Error: ${e.toString()}");
    }
  }

  Future<void> _signinWithApple() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [AppleIDAuthorizationScopes.fullName],
      );
      if (credential.identityToken == null) {
        _emitError("Apple did not provide an identity token.");
        return;
      }
      _emitLoading();
      final result = await _signinUseCase.signinWithApple(
        credential.identityToken!,
      );
      _handleResult(result);
    } catch (e) {
      _emitError("Apple Sign-In Error: ${e.toString()}");
    }
  }

 void _handleResult(BaseResponse<SigninModel> result) {
  switch (result) {
    case SuccessResponse<SigninModel>():
      emit(state.copyWith(
        signinStateParam: BaseState<SigninModel>(data: result.data, isLoading: false),
      ));
    case ErrorResponse(error: final error):
      if (error is AppException) {
        emit(state.copyWith(
          appExceptionParam: error, 
          signinStateParam: BaseState<SigninModel>(isLoading: false),
        ));
      } else {
        _emitError(error.toString());
      }
  }
}
  void _emitLoading() {
    emit(
      state.copyWith(signinStateParam: BaseState<SigninModel>(isLoading: true ,) , appExceptionParam: null),
    );
  }

  void _emitError(String msg) {
    emit(
      state.copyWith(
        signinStateParam: BaseState<SigninModel>(
          errorMessage: msg,
          isLoading: false,
        ),
      ),
    );
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
