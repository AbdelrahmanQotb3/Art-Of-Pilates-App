import 'package:art_of_pilates/app/config/base_state/base_state.dart';
import 'package:art_of_pilates/app/features/profile/domain/model/user_profile_model.dart';

class ProfileStates {
  BaseState<UserProfileModel>? userProfileStateParam;
  final bool hasChanges;
  BaseState<UserProfileModel>? editUserProfileStateParam;

  ProfileStates({this.userProfileStateParam , this.hasChanges = false , this.editUserProfileStateParam});

  ProfileStates copyWith({
    BaseState<UserProfileModel>? userProfileStateParam,
    bool? hasChanges,
    BaseState<UserProfileModel>? editUserProfileStateParam
  }) {
    return ProfileStates(
      userProfileStateParam: userProfileStateParam ?? this.userProfileStateParam,
      hasChanges: hasChanges ?? this.hasChanges,
      editUserProfileStateParam: editUserProfileStateParam ?? this.editUserProfileStateParam
    );
  }
}