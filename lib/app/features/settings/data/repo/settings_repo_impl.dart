import 'package:art_of_pilates/app/config/base_response/base_response.dart';
import 'package:art_of_pilates/app/core/util/session_manager.dart';
import 'package:art_of_pilates/app/features/settings/data/data_source/settings_data_source_contract.dart';
import 'package:art_of_pilates/app/features/settings/data/model/delete_account_response.dart';
import 'package:art_of_pilates/app/features/settings/data/model/logout_response.dart';
import 'package:art_of_pilates/app/features/settings/domain/model/delete_account_model.dart';
import 'package:art_of_pilates/app/features/settings/domain/model/logout_model.dart';
import 'package:art_of_pilates/app/features/settings/domain/repo/settings_repo_contract.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: SettingsRepoContract)
class SettingsRepoImpl implements SettingsRepoContract {
  final SettingsDataSourceContract dataSource;

  SettingsRepoImpl(this.dataSource);

  @override
  Future<BaseResponse<LogoutModel>> logout() async {
    final response = await dataSource.logout();
    switch (response) {
      case SuccessResponse<LogOutResponse>():
        return SuccessResponse(
          data: LogoutModel(
            message: response.data.message!,
            status: response.data.status!,
          ),
        );
      case ErrorResponse(error: final error):
        return ErrorResponse(error: error);
    }
  }

  @override
  Future<BaseResponse<DeleteAccountModel>> deleteAccount() async {
    final SessionManager sessionManager = SessionManager();
    final userId = await sessionManager.getUserId();
    final response = await dataSource.deleteAccount(int.parse(userId!));
    switch (response){
      case SuccessResponse<DeleteAccountResponse>():
        return SuccessResponse(
          data: DeleteAccountModel(
            message: response.data.message!,
            deleted: response.data.deleted!,
          ),
        );
      case ErrorResponse(error: final error):
        return ErrorResponse(error: error);
    }
  }
}
