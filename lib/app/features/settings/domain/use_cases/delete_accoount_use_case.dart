import 'package:art_of_pilates/app/config/base_response/base_response.dart';
import 'package:art_of_pilates/app/features/settings/domain/model/delete_account_model.dart';
import 'package:art_of_pilates/app/features/settings/domain/repo/settings_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeleteAccoountUseCase {
  final SettingsRepoContract settingsRepoContract;

  DeleteAccoountUseCase(this.settingsRepoContract);

  Future<BaseResponse<bool>> call() async {
    final response = await settingsRepoContract.deleteAccount();
    switch (response) {
      case SuccessResponse<DeleteAccountModel>():
        return SuccessResponse(data: response.data.deleted!);
      case ErrorResponse(error: final error):
        return ErrorResponse(error: error);
    }
  }
}