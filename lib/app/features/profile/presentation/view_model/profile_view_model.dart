import 'package:art_of_pilates/app/config/base_response/base_response.dart';
import 'package:art_of_pilates/app/config/base_state/base_state.dart';
import 'package:art_of_pilates/app/core/util/session_manager.dart';
import 'package:art_of_pilates/app/features/profile/domain/model/user_profile_model.dart';
import 'package:art_of_pilates/app/features/profile/domain/use_cases/edit_user_info_use_case.dart';
import 'package:art_of_pilates/app/features/profile/domain/use_cases/get_user_profile_use_case.dart';
import 'package:art_of_pilates/app/features/profile/presentation/view_model/profile_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProfileViewModel extends Cubit<ProfileStates> {
  final SessionManager sessionManager = SessionManager();
  final GetUserProfileUseCase _getUserProfileUseCase;
  final EditUserInfoUseCase _editUserInfoUseCase;

  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  ProfileViewModel(this._getUserProfileUseCase, this._editUserInfoUseCase)
    : super(ProfileStates()) {
    for (final controller in [
      usernameController,
      emailController,
      firstNameController,
      lastNameController,
      phoneController,
      passwordController,
    ]) {
      controller.addListener(_onAnyFieldChanged);
    }
  }

  void _onAnyFieldChanged() {
    if (!state.hasChanges) {
      emit(state.copyWith(hasChanges: true));
    }
  }

  void resetChanges() {
    emit(state.copyWith(hasChanges: false));
  }

  @override
  Future<void> close() {
    for (final controller in [
      usernameController,
      emailController,
      firstNameController,
      lastNameController,
      phoneController,
      passwordController,
    ]) {
      controller.removeListener(_onAnyFieldChanged);
      controller.dispose();
    }
    return super.close();
  }

  Future<BaseResponse<UserProfileModel>> getUserProfile() async {
    emit(
      state.copyWith(
        userProfileStateParam: BaseState<UserProfileModel>(isLoading: true),
      ),
    );
    String? id = await sessionManager.getUserId();
    final response = await _getUserProfileUseCase.call(id!);
    switch (response) {
      case SuccessResponse<UserProfileModel>():
        emit(
          state.copyWith(
            userProfileStateParam: BaseState<UserProfileModel>(
              data: response.data,
              isLoading: false,
            ),
          ),
        );
        return response;
      case ErrorResponse<UserProfileModel>():
        emit(
          state.copyWith(
            userProfileStateParam: BaseState<UserProfileModel>(
              errorMessage: response.error.toString(),
              isLoading: false,
            ),
          ),
        );
        return response;
    }
  }

  Future<BaseResponse<UserProfileModel>> editUserInfo(
  ) async {
    emit(
      state.copyWith(
        editUserProfileStateParam: BaseState<UserProfileModel>(isLoading: true),
      ),
    );
        String? id = await sessionManager.getUserId();

    final response = await _editUserInfoUseCase.call(
      id!,
    firstNameController.text.trim(),
    lastNameController.text.trim(),
    phoneController.text.trim(),
    emailController.text.trim(),
    null
    );
    switch (response) {
      case SuccessResponse<UserProfileModel>():
        emit(
          state.copyWith(
            hasChanges: false,
            editUserProfileStateParam: BaseState<UserProfileModel>(
              data: response.data,
              isLoading: false,
            ),
          ),
        );
        return response;
      case ErrorResponse<UserProfileModel>():
        emit(
          state.copyWith(
            editUserProfileStateParam: BaseState<UserProfileModel>(
              errorMessage: response.error.toString(),
              isLoading: false,
            ),
          ),
        );
        return response;
    }
  }
}
