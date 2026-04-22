import 'package:art_of_pilates/app/config/base_response/base_response.dart';
import 'package:art_of_pilates/app/features/settings/api/api_client/settings_api_client.dart';
import 'package:art_of_pilates/app/features/settings/data/data_source/settings_data_source_contract.dart';
import 'package:art_of_pilates/app/features/settings/data/model/delete_account_response.dart';
import 'package:art_of_pilates/app/features/settings/data/model/logout_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: SettingsDataSourceContract)
class SettingsDataSourceImpl implements SettingsDataSourceContract {
  final SettingsApiClient settingsApiClient;

  SettingsDataSourceImpl(this.settingsApiClient);

  @override
  Future<BaseResponse<LogOutResponse>> logout()async{
    try{
      final response = await settingsApiClient.logout();
      return SuccessResponse(data: response);

    }on Exception catch(e){
      return ErrorResponse(error: e);
    }
  }

  @override
  Future<BaseResponse<DeleteAccountResponse>> deleteAccount(int id)async {
    try{
      final response = await settingsApiClient.deleteAccount(id);
      return SuccessResponse(data: response);

    }on Exception catch(e){
      return ErrorResponse(error: e);
    }
  }
}