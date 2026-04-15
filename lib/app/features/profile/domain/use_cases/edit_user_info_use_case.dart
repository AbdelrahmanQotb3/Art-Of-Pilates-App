import 'package:art_of_pilates/app/config/base_response/base_response.dart';
import 'package:art_of_pilates/app/features/profile/domain/model/user_profile_model.dart';
import 'package:art_of_pilates/app/features/profile/domain/repo/profile_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class EditUserInfoUseCase {
    final ProfileRepoContract _profileRepoContract;

    EditUserInfoUseCase(this._profileRepoContract);

    Future<BaseResponse<UserProfileModel>> call(String id , String? firstName , String? lastName , String? phone,String? email ,String? profileImage) async {
        return await _profileRepoContract.editUser(id , firstName , lastName , phone,email ,profileImage);
    }
}