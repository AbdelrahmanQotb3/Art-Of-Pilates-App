import 'package:art_of_pilates/app/config/base_response/base_response.dart';
import 'package:art_of_pilates/app/features/signup/domain/model/signup_model.dart';

abstract class SignupRepoContract {
  Future<BaseResponse<SignupModel>> signup(String email, String password, String firstName, String lastName);
}