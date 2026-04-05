import 'package:art_of_pilates/app/config/base_response/base_response.dart';
import 'package:art_of_pilates/app/features/signup/domain/model/signup_model.dart';
import 'package:art_of_pilates/app/features/signup/domain/repo/signup_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class SignupUseCase {
  final SignupRepoContract _signupRepoContract;
  SignupUseCase(this._signupRepoContract);
  Future<BaseResponse<SignupModel>> call(String email, String password, String firstName, String lastName) {
    return _signupRepoContract.signup(email, password, firstName, lastName);
  }
}