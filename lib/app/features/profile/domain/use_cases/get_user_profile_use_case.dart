import 'package:art_of_pilates/app/config/base_response/base_response.dart';
import 'package:art_of_pilates/app/features/profile/domain/model/user_profile_model.dart';
import 'package:art_of_pilates/app/features/profile/domain/repo/profile_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetUserProfileUseCase {
  final ProfileRepoContract _profileRepoContract;

  GetUserProfileUseCase(this._profileRepoContract);

  Future<BaseResponse<UserProfileModel>> call(String id) async  => await _profileRepoContract.getUserProfile(id);
}