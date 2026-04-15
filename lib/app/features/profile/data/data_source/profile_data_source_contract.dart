import 'package:art_of_pilates/app/config/base_response/base_response.dart';
import 'package:art_of_pilates/app/features/profile/data/model/current_user_response.dart';

abstract class ProfileDataSourceContract {
  Future<BaseResponse<CurrentUserResponse>> getUser(String id);
  Future<BaseResponse<CurrentUserResponse>> editUser(String id , String? firstName , String? lastName , String? phone,String? email ,String? profileImage);
}