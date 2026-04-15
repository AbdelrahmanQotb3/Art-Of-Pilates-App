import 'package:art_of_pilates/app/config/base_response/base_response.dart';
import 'package:art_of_pilates/app/features/profile/api/api_client/profile_api_client.dart';
import 'package:art_of_pilates/app/features/profile/data/data_source/profile_data_source_contract.dart';
import 'package:art_of_pilates/app/features/profile/data/model/current_user_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProfileDataSourceContract)
class ProfileDataSourceImpl implements ProfileDataSourceContract {
  final ProfileApiClient _apiClient;

  ProfileDataSourceImpl(this._apiClient);
  @override
  Future<BaseResponse<CurrentUserResponse>> getUser(String id)async {
    try{
      final response = await _apiClient.getUser(id);
      return SuccessResponse(data: response);
    }on Exception catch(e){
      return ErrorResponse(error: e);
    }
  }
  
  @override
  Future<BaseResponse<CurrentUserResponse>> editUser(String id, String? firstName, String? lastName, String? phone, String? email, String? profileImage) async{
    final Map<String, dynamic> updateData = {
  if (firstName != null && firstName.isNotEmpty) 'firstName': firstName,
  if (lastName != null && lastName.isNotEmpty) 'lastName': lastName,
  if (phone != null && phone.isNotEmpty) 'phone': phone,
  if (email != null && email.isNotEmpty) 'email': email,
  if (profileImage != null && profileImage.isNotEmpty) 'profileImage': profileImage,
};  
    try{
      final response = await _apiClient.editUser(id, updateData);
      return SuccessResponse(data: response);
    }on Exception catch(e){
      return ErrorResponse(error: e);
    }
  }
}
