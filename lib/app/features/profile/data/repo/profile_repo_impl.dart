import 'package:art_of_pilates/app/config/base_response/base_response.dart';
import 'package:art_of_pilates/app/features/profile/data/data_source/profile_data_source_contract.dart';
import 'package:art_of_pilates/app/features/profile/data/model/current_user_response.dart';
import 'package:art_of_pilates/app/features/profile/domain/model/user_profile_model.dart';
import 'package:art_of_pilates/app/features/profile/domain/repo/profile_repo_contract.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProfileRepoContract)
class ProfileRepoImpl implements ProfileRepoContract {
  final ProfileDataSourceContract _profileDataSourceContract;

  ProfileRepoImpl(this._profileDataSourceContract);

  @override
  Future<BaseResponse<UserProfileModel>> getUserProfile(String id)async {
    final response = await _profileDataSourceContract.getUser(id);
    switch (response) {
      case SuccessResponse<CurrentUserResponse>():
        UserProfileModel userProfileModel = UserProfileModel(
          id: response.data.user!.id,
          email: response.data.user!.email,
          firstName: response.data.user!.firstName,
          lastName: response.data.user!.lastName,
          role: response.data.user!.role,
          profileImage: response.data.user!.profileImage,
          phone: response.data.user!.phone
        );
        return SuccessResponse(data: userProfileModel);
      case ErrorResponse(error: final error):
        return ErrorResponse(error: error);
    }
  }

  @override
  Future<BaseResponse<UserProfileModel>> editUser(String id, String? firstName, String? lastName, String? phone, String? email, String? profileImage)async {
    final response = await _profileDataSourceContract.editUser(id, firstName, lastName, phone, email, profileImage);
    switch (response) {
      case SuccessResponse<CurrentUserResponse>():
        UserProfileModel userProfileModel = UserProfileModel(
          id: response.data.user!.id,
          email: response.data.user!.email,
          firstName: response.data.user!.firstName,
          lastName: response.data.user!.lastName,
          role: response.data.user!.role,
          profileImage: response.data.user!.profileImage,
          phone: response.data.user!.phone
        );
        return SuccessResponse(data: userProfileModel);
      case ErrorResponse(error: final error):
        return ErrorResponse(error: error);
    }
  }
}