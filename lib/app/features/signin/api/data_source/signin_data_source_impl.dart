import 'package:art_of_pilates/app/config/base_response/base_response.dart';
import 'package:art_of_pilates/app/core/util/exceptions/auth/signin_exception.dart';
import 'package:art_of_pilates/app/core/util/session_manager.dart';
import 'package:art_of_pilates/app/features/signin/api/api_client/signin_api_client.dart';
import 'package:art_of_pilates/app/features/signin/data/data_source/signin_data_source_contract.dart';
import 'package:art_of_pilates/app/features/signin/data/model/signin_response.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: SigninDataSourceContract)
class SigninDataSourceImpl implements SigninDataSourceContract {
  SessionManager sessionManager = SessionManager();
  final SigninApiClient _apiClient;

  SigninDataSourceImpl(this._apiClient);

  @override
Future<BaseResponse<SigninResponse>> signin(String email, String password) async {
  try {
    final response = await _apiClient.signin({'email': email, 'password': password});
    
    if (response.token == null) {
      return ErrorResponse(
        error: SigninException(error: response.message ?? 'Sign in failed'),
      );
    }
    
    await sessionManager.setToken(response.token!);
    await sessionManager.setUserId(response.user!.id.toString());
    return SuccessResponse(data: response);
  } on DioException catch (e) {
    final serverMessage = e.response?.data['status'] 
                       ?? e.response?.data['message'] 
                       ?? 'Sign in failed';
    return ErrorResponse(error: SigninException(error: serverMessage.toString()));
  } on Exception catch (e) {
    return ErrorResponse(error: SigninException(error: e.toString()));
  }
}

  @override
  Future<BaseResponse<SigninResponse>> signinWithApple(String token) async {
    try {
      final response = await _apiClient.signinWithSocial({
        'token': token,
        'provider': 'apple',
      });
      String responseToken = response.token!;
      int userId = response.user!.id!;
      await sessionManager.setToken(responseToken);
      await sessionManager.setUserId(userId.toString());
      return SuccessResponse(data: response);
    } on Exception catch (e) {
      return ErrorResponse(error: e);
    }
  }

  @override
  Future<BaseResponse<SigninResponse>> signinWithGoogle(String token) async {
    try {
      final response = await _apiClient.signinWithSocial({
        'token': token,
        'provider': 'google',
      });
      String responseToken = response.token!;
      int userId = response.user!.id!;
      await sessionManager.setToken(responseToken);
      await sessionManager.setUserId(userId.toString());
      return SuccessResponse(data: response);
    } on Exception catch (e) {
      return ErrorResponse(error: SigninWithGoogleException());
    }
  }
}
