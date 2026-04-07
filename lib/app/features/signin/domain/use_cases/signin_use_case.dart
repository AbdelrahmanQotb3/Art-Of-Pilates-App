import 'package:art_of_pilates/app/config/base_response/base_response.dart';
import 'package:art_of_pilates/app/features/signin/domain/model/signin_model.dart';
import 'package:art_of_pilates/app/features/signin/domain/repo/signin_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class SigninUseCase {
  final SigninRepoContract _signinRepoContract;
  SigninUseCase(this._signinRepoContract);
  Future<BaseResponse<SigninModel>> signin(String email, String password) =>
      _signinRepoContract.signin(email, password);
      
  Future<BaseResponse<SigninModel>> signinWithGoogle(String token) {
    return _signinRepoContract.signinWithGoogle(token);
  }

  Future<BaseResponse<SigninModel>> signinWithApple(String token) {
    return _signinRepoContract.signinWithApple(token);
  }
}
