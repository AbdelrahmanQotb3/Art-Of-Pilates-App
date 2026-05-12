import 'package:art_of_pilates/app/config/base_response/base_response.dart';
import 'package:art_of_pilates/app/features/signin/data/data_source/signin_data_source_contract.dart';
import 'package:art_of_pilates/app/features/signin/data/model/signin_response.dart';
import 'package:art_of_pilates/app/features/signin/domain/model/signin_model.dart';
import 'package:art_of_pilates/app/features/signin/domain/repo/signin_repo_contract.dart';
import 'package:injectable/injectable.dart';
@Injectable(as: SigninRepoContract)
class SigninRepoImpl implements SigninRepoContract {
  final SigninDataSourceContract _dataSource;
  SigninRepoImpl(this._dataSource);

  @override
Future<BaseResponse<SigninModel>> signin(String email, String password) async {
  final response = await _dataSource.signin(email, password);
  switch (response) {
    case SuccessResponse<SigninResponse>():
      // Guard against null fields even on success
      final user = response.data.user;
      SigninModel signinModel = SigninModel(
        message: response.data.message ?? '',
        email: user?.email,
        firstName: user?.firstName,
        lastName: user?.lastName,
        role: user?.role,
        id: user?.id,
      );
      return SuccessResponse(data: signinModel);
    case ErrorResponse(error: final error):
      return ErrorResponse(error: error); // just pass it through
  }
}
  @override
  Future<BaseResponse<SigninModel>> signinWithApple(String token) async {
    final response = await _dataSource.signinWithApple(token);
    switch (response){
      case SuccessResponse<SigninResponse>():
        SigninModel signinModel = SigninModel(
          message: response.data.message!,
          email: response.data.user!.email,
          firstName: response.data.user!.firstName,
          lastName: response.data.user!.lastName,
          role: response.data.user!.role,
          id: response.data.user!.id,
        );
        return SuccessResponse(data: signinModel);
      case ErrorResponse(error: final error):
        return ErrorResponse(error: error);    
    } 
  }
  
  @override
  Future<BaseResponse<SigninModel>> signinWithGoogle(String token) async {
    final response = await _dataSource.signinWithGoogle(token);
    switch (response){
      case SuccessResponse<SigninResponse>():
        SigninModel signinModel = SigninModel(
          message: response.data.message!,
          email: response.data.user!.email,
          firstName: response.data.user!.firstName,
          lastName: response.data.user!.lastName,
          role: response.data.user!.role,
          id: response.data.user!.id,
          phone: response.data.user!.phone
        );
        return SuccessResponse(data: signinModel);
      case ErrorResponse(error: final error):
        return ErrorResponse(error: error);    
    }
  }
}
