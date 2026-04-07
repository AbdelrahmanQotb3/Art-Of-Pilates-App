import 'package:art_of_pilates/app/config/base_response/base_response.dart';
import 'package:art_of_pilates/app/features/signin/domain/model/signin_model.dart';

abstract class SigninRepoContract {
  Future<BaseResponse<SigninModel>> signin(String email, String password);
  Future<BaseResponse<SigninModel>> signinWithGoogle(String token);
  Future<BaseResponse<SigninModel>> signinWithApple(String token);
}