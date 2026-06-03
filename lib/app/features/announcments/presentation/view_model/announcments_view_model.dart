import 'package:art_of_pilates/app/config/base_response/base_response.dart';
import 'package:art_of_pilates/app/config/base_state/base_state.dart';
import 'package:art_of_pilates/app/features/announcments/domain/model/announcments_model.dart';
import 'package:art_of_pilates/app/features/announcments/domain/use_cases/get_announcments_use_case.dart';
import 'package:art_of_pilates/app/features/announcments/presentation/view_model/announcments_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class AnnouncmentsViewModel extends Cubit<AnnouncmentsStates> {
  final GetAnnouncmentsUseCase _getAnnouncmentsUseCase;

  AnnouncmentsViewModel(this._getAnnouncmentsUseCase): super(AnnouncmentsStates());

  Future<BaseResponse<AnnouncmentsModel>> getAnnouncments() async {
    emit(state.copyWith(announcmentsState: BaseState(isLoading: true)));
    final response = await _getAnnouncmentsUseCase.call();

    switch(response){
      case SuccessResponse<AnnouncmentsModel>():
        emit(state.copyWith(announcmentsState: BaseState(data: response.data, isLoading: false)));
        return response;
      case ErrorResponse<AnnouncmentsModel>():
        emit(state.copyWith(announcmentsState: BaseState(errorMessage: response.error.toString(), isLoading: false)));
        return response;
    }
  }
}