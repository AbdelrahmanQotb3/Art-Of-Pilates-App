import 'package:art_of_pilates/app/config/base_response/base_response.dart';
import 'package:art_of_pilates/app/features/settings/data/model/delete_account_response.dart';
import 'package:art_of_pilates/app/features/settings/data/model/logout_response.dart';

abstract class SettingsDataSourceContract {
  Future<BaseResponse<LogOutResponse>> logout();
  Future<BaseResponse<DeleteAccountResponse>> deleteAccount(int id);
}