import 'package:art_of_pilates/app/config/base_response/base_response.dart';
import 'package:art_of_pilates/app/features/signup/data/model/signup_response.dart';

abstract class SignupDataSourceContract {
  Future<BaseResponse<SignupResponse>> signup(String email, String password, String firstName, String lastName);
  Future<BaseResponse<SignupResponse>> signupWithGoogle(String token);
  Future<BaseResponse<SignupResponse>> signupWithApple(String token);
}