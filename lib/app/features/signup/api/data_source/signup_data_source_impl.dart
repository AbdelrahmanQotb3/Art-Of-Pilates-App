import 'package:art_of_pilates/app/config/base_response/base_response.dart';
import 'package:art_of_pilates/app/core/util/exceptions/auth/signup_exception.dart';
import 'package:art_of_pilates/app/features/signup/api/api_client/signup_api_client.dart';
import 'package:art_of_pilates/app/features/signup/data/data_source/signup_data_source_contract.dart';
import 'package:art_of_pilates/app/features/signup/data/model/signup_response.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: SignupDataSourceContract)
class SignupDataSourceImpl implements SignupDataSourceContract {
  final SignupApiClient _signupApiClient;

  SignupDataSourceImpl(this._signupApiClient);

  @override
  Future<BaseResponse<SignupResponse>> signup(
    String email,
    String password,
    String firstName,
    String lastName,
  ) async {
    try {
      final response = await _signupApiClient.signup({
        'email': email,
        'password': password,
        'first_name': firstName,
        'last_name': lastName,
        'role': 'Client',
      });
      return SuccessResponse(data: response);
    }
    on DioException catch (e) {
      final serverMessage = e.response?.data['status'] 
                       ?? e.response?.data['message'] 
                       ?? 'Sign up failed';
      return ErrorResponse(error: serverMessage);
    }
     on Exception catch (e) {
      return ErrorResponse(error: SignupException(error: e.toString()));
    }
  }

  @override
  Future<BaseResponse<SignupResponse>> signupWithGoogle(String token) async {
    try {
      final response = await _signupApiClient.signupWithSocial({
        'token': token,
        'provider': 'google',
      });
      return SuccessResponse(data: response);
    }
      on DioException catch (e) {
        final serverMessage = e.response?.data['status'] 
                         ?? e.response?.data['message'] 
                         ?? 'Sign up failed';
        return ErrorResponse(error: SignupException(error: serverMessage));
      }
    on Exception catch (e) {
      return ErrorResponse(error: SignupException(error: e.toString()));
    }
  }

  @override
  Future<BaseResponse<SignupResponse>> signupWithApple(String token) async {
    try {
      final response = await _signupApiClient.signupWithSocial({
        'token': token,
        'provider': 'apple',
      });
      return SuccessResponse(data: response);
    } on Exception catch (e) {
      return ErrorResponse(error: e);
    }
  }
}
