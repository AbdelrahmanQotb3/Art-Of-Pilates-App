import 'package:art_of_pilates/app/config/base_response/base_response.dart';
import 'package:art_of_pilates/app/features/signup/data/data_source/signup_data_source_contract.dart';
import 'package:art_of_pilates/app/features/signup/data/model/signup_response.dart';
import 'package:art_of_pilates/app/features/signup/domain/model/signup_model.dart';
import 'package:art_of_pilates/app/features/signup/domain/repo/signup_repo_contract.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: SignupRepoContract)
class SignupRepoImpl implements SignupRepoContract {
  final SignupDataSourceContract _dataSource;
  SignupRepoImpl(this._dataSource);
  @override
  Future<BaseResponse<SignupModel>> signup(
    String email,
    String password,
    String firstName,
    String lastName,
  ) async {
    final response = await _dataSource.signup(
      email,
      password,
      firstName,
      lastName,
    );
    switch (response) {
      case SuccessResponse<SignupResponse>():
        SignupModel model = SignupModel(
          email: response.data.user!.email,
          firstName: response.data.user!.firstName,
          lastName: response.data.user!.lastName,
          role: response.data.user!.role,
          id: response.data.user!.id,
          message: response.data.message,
        );
        return SuccessResponse(data: model);
      case ErrorResponse<SignupResponse>():
        return ErrorResponse(error: response.error);
    }
  }
}
