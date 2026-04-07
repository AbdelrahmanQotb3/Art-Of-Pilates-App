import 'package:art_of_pilates/app/config/base_response/base_response.dart';
import 'package:art_of_pilates/app/features/signin/api/api_client/signin_api_client.dart';
import 'package:art_of_pilates/app/features/signin/data/data_source/signin_data_source_contract.dart';
import 'package:art_of_pilates/app/features/signin/data/model/signin_response.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: SigninDataSourceContract)
class SigninDataSourceImpl implements SigninDataSourceContract {
  FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  final SigninApiClient _apiClient;

  SigninDataSourceImpl(this._apiClient);

  @override
  Future<BaseResponse<SigninResponse>> signin(
    String email,
    String password,
  ) async {
    try {
      final response = await _apiClient.signin({
        'email': email,
        'password': password,
      });
      String token = response.token!;
      int userId = response.user!.id!;
      await secureStorage.write(key: 'token', value: token);
      await secureStorage.write(key: 'userId', value: userId.toString());
      return SuccessResponse(data: response);
    } on Exception catch (e) {
      return ErrorResponse(error: e);
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
      await secureStorage.write(key: 'token', value: responseToken);
      await secureStorage.write(key: 'userId', value: userId.toString());
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
      await secureStorage.write(key: 'token', value: responseToken);
      await secureStorage.write(key: 'userId', value: userId.toString());
      return SuccessResponse(data: response);
    } on Exception catch (e) {
      return ErrorResponse(error: e);
    }
  }
}
