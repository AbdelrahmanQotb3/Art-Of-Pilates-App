import 'package:art_of_pilates/app/config/base_response/base_response.dart';
import 'package:art_of_pilates/app/features/profile/domain/model/user_profile_model.dart';

abstract class ProfileRepoContract {
  Future<BaseResponse<UserProfileModel>> getUserProfile(String id);

  Future<BaseResponse<UserProfileModel>> editUser(String id , String? firstName , String? lastName , String? phone,String? email ,String? profileImage);
}