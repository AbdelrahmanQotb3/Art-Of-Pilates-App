import 'package:art_of_pilates/app/config/base_response/base_response.dart';
import 'package:art_of_pilates/app/features/signin/data/model/signin_response.dart';

abstract class SigninDataSourceContract {
  Future<BaseResponse<SigninResponse>> signin(String email, String password);
}