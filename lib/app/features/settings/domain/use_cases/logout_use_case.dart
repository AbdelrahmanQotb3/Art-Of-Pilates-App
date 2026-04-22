import 'package:art_of_pilates/app/config/base_response/base_response.dart';
import 'package:art_of_pilates/app/features/settings/domain/model/logout_model.dart';
import 'package:art_of_pilates/app/features/settings/domain/repo/settings_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class LogoutUseCase {
  final SettingsRepoContract settingsRepoContract;
  LogoutUseCase(this.settingsRepoContract);
  Future<BaseResponse<LogoutModel>> call ()async => await settingsRepoContract.logout();
}