import 'package:art_of_pilates/app/config/base_response/base_response.dart';
import 'package:art_of_pilates/app/config/base_state/base_state.dart';
import 'package:art_of_pilates/app/features/signup/domain/model/signup_model.dart';
import 'package:art_of_pilates/app/features/signup/domain/use_case/signup_use_case.dart';
import 'package:art_of_pilates/app/features/signup/presentation/view_model/signup_events.dart';
import 'package:art_of_pilates/app/features/signup/presentation/view_model/signup_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

@injectable
class SignupViewModel extends Cubit<SignupStates> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final SignupUseCase _signupUseCase;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
    serverClientId:
        '147658495150-blnq1kduep76t8vcrtsfn8lq6qi5k0d9.apps.googleusercontent.com',
  );
  bool isSocialSignup = false;

  SignupViewModel(this._signupUseCase) : super(SignupStates());

  void doIntent(SignupEvents event) {
    if (event is SignupEvent) {
      signup(
        firstNameController.text,
        lastNameController.text,
        emailController.text,
        passwordController.text,
      );
    } else if (event is SignupWithGoogleEvent) {
      _signupWithGoogle();
    } else if (event is SignupWithAppleEvent) {
      _signupWithApple();
    }
  }

  // --- Logic for Google ---
  Future<void> _signupWithGoogle() async {
    isSocialSignup = true;
    try {
      final googleUser = await _googleSignIn.signIn();

      // Handle user dismissing the dialog
      if (googleUser == null) return;

      final auth = await googleUser.authentication;

      // SAFETY CHECK: Prevents the "Null check operator" crash
      if (auth.idToken == null) {
        _emitError(
          "Google did not provide an ID Token. Please verify your SHA-1 fingerprint in Firebase.",
        );
        return;
      }

      _emitLoading();
      final result = await _signupUseCase.signupWithGoogle(auth.idToken!);
      _handleResult(result);
    } catch (e) {
      _emitError("Google Sign-In Error: ${e.toString()}");
    }
  }

  // --- Logic for Apple ---
  Future<void> _signupWithApple() async {
    isSocialSignup = true;
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      // SAFETY CHECK: Ensure the token exists before using '!'
      if (credential.identityToken == null) {
        _emitError("Apple did not provide an Identity Token.");
        return;
      }

      _emitLoading();
      final result = await _signupUseCase.signupWithApple(
        credential.identityToken!,
      );
      _handleResult(result);
    } catch (e) {
      _emitError("Apple Sign-In Error: ${e.toString()}");
    }
  }

  // --- Standard Email Signup ---
  Future<void> signup(
    String firstName,
    String lastName,
    String email,
    String password,
  ) async {
    isSocialSignup = false;
    _emitLoading();
    final result = await _signupUseCase(email, password, firstName, lastName);
    _handleResult(result);
  }

  // --- State Helpers ---
  void _emitLoading() {
    emit(
      state.copyWith(signupStateParam: BaseState<SignupModel>(isLoading: true)),
    );
  }

  void _emitError(String msg) {
    emit(
      state.copyWith(
        signupStateParam: BaseState<SignupModel>(
          errorMessage: msg,
          isLoading: false,
        ),
      ),
    );
  }

  void _handleResult(BaseResponse<SignupModel> result) {
    if (result is SuccessResponse<SignupModel>) {
      emit(
        state.copyWith(
          signupStateParam: BaseState<SignupModel>(
            data: result.data,
            isLoading: false,
          ),
        ),
      );
    } else {
      _emitError((result as ErrorResponse).error.toString());
    }
  }

  @override
  Future<void> close() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }
}
