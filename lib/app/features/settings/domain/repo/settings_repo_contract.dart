import 'package:art_of_pilates/app/config/base_response/base_response.dart';
import 'package:art_of_pilates/app/features/settings/domain/model/delete_account_model.dart';
import 'package:art_of_pilates/app/features/settings/domain/model/logout_model.dart';

abstract class SettingsRepoContract {
  Future<BaseResponse<LogoutModel>> logout();
  Future<BaseResponse<DeleteAccountModel>> deleteAccount();
}